const fs = require('fs');
const readline = require('readline');
const path = require('path');

// Function to parse factories from the input file
function parseFactories(data) {
  const factoryRegex = /factory\s*:\s*(\w+)\s*do\s*\|?(\w*)\|?\s*$/gm;
  let match;
  const factories = [];

  while ((match = factoryRegex.exec(data)) !== null) {
    factories.push(match[1]);
  }

  return factories;
}

// Function to create files for each factory
function createFactoryFiles(factories, data, outputDir) {
  factories.forEach(factoryName => {
    const filePath = path.join(outputDir, `${factoryName}.rb`);
    if (!fs.existsSync(filePath)) {
      const factoryContentRegex = new RegExp(`factory\\s*:\\s*${factoryName}\\s*do\\s*([\\s\\S]*?)end`, 'm');
      const factoryContentMatch = factoryContentRegex.exec(data);
      if (factoryContentMatch) {
        const content = `FactoryBot.define do\n  factory :${factoryName} do\n${factoryContentMatch[1].trim()}\n  end\nend\n`;
        fs.writeFileSync(filePath, content.trim());
        console.log(`Created: ${filePath}`);
      }
    } else {
      console.log(`Skipped (already exists): ${filePath}`);
    }
  });
}

// Main function to execute the script
async function main() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  const question = (query) => new Promise(resolve => rl.question(query, resolve));

  try {
    const inputFilename = await question('Enter the input filename: ');
    const outputDir = await question('Enter the output directory: ');

    if (!fs.existsSync(inputFilename)) {
      console.error('Input file does not exist.');
      return;
    }

    if (!fs.existsSync(outputDir)) {
      fs.mkdirSync(outputDir, { recursive: true });
    }

    const data = fs.readFileSync(inputFilename, 'utf-8');
    const factories = parseFactories(data);
    createFactoryFiles(factories, data, outputDir);
  } catch (error) {
    console.error('An error occurred:', error.message);
  } finally {
    rl.close();
  }
}

main();
