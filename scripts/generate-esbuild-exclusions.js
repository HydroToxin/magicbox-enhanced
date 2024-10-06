const fs = require('fs');
const path = require('path');

// Set paths
const importmapPath = path.resolve(__dirname, '../config/importmap.rb');
const packageJsonPath = path.resolve(__dirname, '../package.json');

// Read the content of importmap.rb
fs.readFile(importmapPath, 'utf8', (err, data) => {
  if (err) {
    console.error('Error reading the importmap:', err);
    process.exit(1);
  }

  // Extract all pinned modules
  const pinRegex = /pin\s+"([^"]+)"/g;
  let match;
  const excludedModules = [];

  while ((match = pinRegex.exec(data)) !== null) {
    excludedModules.push(match[1]);
  }

  // Generate command line options for esbuild
  const excludeString = excludedModules.map(module => `--external:${module}`).join(' ');

  // Read the package.json file
  fs.readFile(packageJsonPath, 'utf8', (err, packageData) => {
    if (err) {
      console.error('Error reading the package.json:', err);
      process.exit(1);
    }

    // Parse the JSON content
    const packageJson = JSON.parse(packageData);

    // Update the build script
    if (!packageJson.scripts) {
      packageJson.scripts = {};
    }
    packageJson.scripts.build =
      `esbuild app/javascript/*.* app/javascript/legacy/*.js --bundle --watch --format=esm --outdir=app/assets/builds --public-path=/assets --external:@rails/ujs ${excludeString}`;

    // Write the changes back to package.json
    fs.writeFile(packageJsonPath, JSON.stringify(packageJson, null, 2), (err) => {
      if (err) {
        console.error('Error writing to package.json:', err);
        process.exit(1);
      }
      console.log('package.json successfully updated.');
    });
  });
});
