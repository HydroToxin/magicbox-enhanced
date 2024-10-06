import * as sass from 'sass'
import fs from 'fs/promises';
import chokidar from 'chokidar';

// Define entry and output paths
const entryFile = 'app/assets/stylesheets/application.scss'; // Passe diesen Pfad je nach deinem Projekt an
const outputFile = 'app/assets/builds/application.css';

// Function to process SCSS
async function processSCSS(inputFile, outputFile) {
  try {
    // Compile SCSS to CSS
    const result = sass.compile(inputFile, {
      loadPaths: ['node_modules'], // Include node_modules for imports
      style: 'expanded', // Optional: Choose 'compressed' for minified CSS
    });

    // Write the compiled CSS to the output file
    await fs.writeFile(outputFile, result.css);
    if (result.map) {
      await fs.writeFile(`${outputFile}.map`, result.map.toString());
    }

    console.log('⚡ SCSS build complete! ⚡');
  } catch (error) {
    console.error('Error processing SCSS:', error);
  }
}

// Watch for changes if running in watch mode
const watch = process.argv.includes('--watch');
if (watch) {
  chokidar.watch(entryFile).on('change', () => {
    console.log('👀 Detected SCSS change, rebuilding...');
    processSCSS(entryFile, outputFile);
  });
  console.log('👀 Watching for SCSS changes...');
} else {
  // Run once if not in watch mode
  processSCSS(entryFile, outputFile);
}
