import * as sass from 'sass';
import fs from 'fs/promises';
import chokidar from 'chokidar';
import path from 'path';

// Define entry and output paths for SCSS
const entryFile = 'app/assets/stylesheets/application.scss'; // Passe diesen Pfad je nach deinem Projekt an
const outputFile = 'app/assets/builds/application.css';

// Define target directory for font-awesome fonts
const fontAwesomeSource = 'node_modules/@fortawesome/fontawesome-free/webfonts';
const fontAwesomeDestination = 'public/fonts/font-awesome';

// Function to process SCSS
async function processSCSS(inputFile, outputFile) {
  try {
    // Compile SCSS to CSS
    const result = sass.compile(inputFile, {
      loadPaths: ['node_modules'], // Include node_modules for imports
      style: 'expanded', // Optional: Choose 'compressed' for minified CSS
    });

    // Write the compiled CSS to the output file
    await fs.mkdir(path.dirname(outputFile), { recursive: true });
    await fs.writeFile(outputFile, result.css);
    if (result.map) {
      await fs.writeFile(`${outputFile}.map`, result.map.toString());
    }

    console.log('⚡ SCSS build complete! ⚡');
  } catch (error) {
    console.error('Error processing SCSS:', error);
  }
}

// Function to copy webfonts
async function copyFonts() {
  try {
    await fs.mkdir(fontAwesomeDestination, { recursive: true });
    const files = await fs.readdir(fontAwesomeSource);
    for (const file of files) {
      const sourceFile = path.join(fontAwesomeSource, file);
      const destFile = path.join(fontAwesomeDestination, file);
      await fs.copyFile(sourceFile, destFile);
    }
    console.log('✔ Webfonts copied successfully to public/assets/font-awesome!');
  } catch (error) {
    console.error('Error copying webfonts:', error);
  }
}

// Watch for changes if running in watch mode
const watch = process.argv.includes('--watch');
if (watch) {
  chokidar.watch(entryFile).on('change', () => {
    console.log('👀 Detected SCSS change, rebuilding and copying fonts...');
    processSCSS(entryFile, outputFile);
    copyFonts();
  });
  console.log('👀 Watching for SCSS changes...');
} else {
  // Run once if not in watch mode
  processSCSS(entryFile, outputFile);
  copyFonts();
}
