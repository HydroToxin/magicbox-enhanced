import esbuild from "esbuild";
import { sync as globSync } from "glob";
import fs from "fs";

// Check environment variable
console.log('NODE_ENV:', process.env.NODE_ENV);

// Determine if the environment is production
const isProduction = process.env.NODE_ENV === 'production';

// Check entries and ensure output directory exists
const entryPoints = globSync("app/javascript/**/*.js").filter(file => !file.includes("legacy"));
console.log('Found entries:', entryPoints);

if (entryPoints.length === 0) {
  console.error('No valid entries found. Please check the file path.');
}

// Ensure the output directory exists and set permissions
const outputDir = 'public/assets';
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
  console.log(`Created directory: ${outputDir}`);
}
fs.chmodSync(outputDir, 0o755);

// Configuration object for the build
const buildOptions = {
  entryPoints,
  outdir: outputDir,
  bundle: true,
  platform: 'browser',
  sourcemap: isProduction ? false : 'external', // Explicitly generate external sourcemaps in development
  loader: {
    '.js': 'jsx',
    '.css': 'css',
  },
};

// Function to execute the build process
async function executeBuild() {
  try {
    console.log('Building...');
    if (!isProduction && process.argv.includes('--watch')) {
      console.log('In development mode with watch enabled...');
      const ctx = await esbuild.context(buildOptions);
      ctx.watch(() => {
        console.log("👀 Watching for changes...");
      });
    } else {
      console.log('Executing once-off build process...');
      await esbuild.build(buildOptions);
      console.log("⚡ Build complete!");
    }
  } catch (error) {
    console.error('Error in the build process:', error);
    process.exit(1);
  }
}

// Start the build process
executeBuild().catch((error) => {
  console.error('Unexpected error while executing the build process:', error);
});

// Monitoring for unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled promise rejection:', reason);
});
