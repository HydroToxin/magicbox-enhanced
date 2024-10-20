const esbuild = require('esbuild');
const glob = require('glob');

// Finden Sie alle TypeScript Dateien:
const entryPoints = glob.sync('app/javascript/*.{js,ts,tsx}');
console.log("Found entry points:", entryPoints); // Fügen Sie dies hinzu, um zu überprüfen

async function buildAndWatch() {
  try {
    const ctx = await esbuild.context({
      entryPoints: entryPoints,
      bundle: true,
      sourcemap: false,
      format: 'esm',
      outdir: 'app/assets/builds',
      publicPath: 'public/assets',
      loader: { '.ts': 'ts', '.tsx': 'tsx', '.js': 'js' },
      logLevel: 'info',
      tsconfig: 'tsconfig.json'
    });

    if (process.argv.includes('--watch')) {
      await ctx.watch();
      console.log('Watching for changes...');
    } else {
      await ctx.rebuild();
      console.log('Build completed successfully!');
    }
  } catch (error) {
    console.error('Build failed:', error);
    process.exit(1);
  }
};

buildAndWatch();
