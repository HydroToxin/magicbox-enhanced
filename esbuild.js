import esbuild from "esbuild";
import { sync as globSync } from "glob";

// Determine if the environment is production
const isProduction = process.env.NODE_ENV === 'production';

// Configuration object for the build
const buildOptions = {
  entryPoints: globSync("app/javascript/**/*.js").filter(file => !file.includes("legacy")),
  outdir: 'public/assets', // Output directory
  bundle: true, // Always bundle to ensure node_modules are included
  platform: 'browser', // Target platform
  sourcemap: !isProduction, // Source maps for development
  loader: {
    '.js': 'jsx',
    '.css': 'css',
  },
};

// Function to build and possibly watch
async function buildAndWatch() {

  // Start the build process and watch for changes if in development
  if (!isProduction) {
    const ctx = await esbuild.context(buildOptions);
    ctx.watch(() => {
      console.log("👀 Watching for changes...");
    });
  } else {
    await esbuild.build(buildOptions);
    console.log("⚡ Production build complete!");
  }
}

// Execute the build process
buildAndWatch().catch((error) => {
  console.error('Build failed:', error);
  process.exit(1);
});
