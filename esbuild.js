// Import esbuild and required function from glob
import esbuild from "esbuild";
import { sync as globSync } from "glob";

// Check if the watch mode is active
const watch = process.argv.includes("--watch");

// Configuration object for the build
const buildOptions = {
  // Filter out files in the 'legacy' directory
  entryPoints: globSync("app/javascript/**/*.js"),
  outdir: "app/assets/builds",
  publicPath: "assets",
  bundle: true,
  metafile: true,
};

// Function to build and possibly watch
async function buildAndWatch() {
  if (watch) {
    const ctx = await esbuild.context(buildOptions); // Create a context for watch mode
    await ctx.watch(); // Start watching
    console.log("👀 Watching for changes...");
  } else {
    await esbuild.build(buildOptions); // Just build once
    console.log("⚡ JS build complete! ⚡");
  }
}

// Execute the build process
buildAndWatch().catch(() => process.exit(1)); // Exit with an error code in case of failure
