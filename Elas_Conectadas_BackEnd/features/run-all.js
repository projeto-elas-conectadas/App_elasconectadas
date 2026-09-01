const { spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const backendRoot = path.join(__dirname, '..');
const features = fs
  .readdirSync(__dirname)
  .filter((file) => file.endsWith('.feature'))
  .sort();

if (features.length === 0) {
  console.error('Nenhum arquivo .feature encontrado em features/.');
  process.exit(1);
}

console.log(`Executando ${features.length} feature(s) Cucumber juntas:\n`);
for (const file of features) {
  console.log(`  - ${file}`);
}
console.log('');

const result = spawnSync('npx', ['cucumber-js', '--config', 'cucumber.json'], {
  cwd: backendRoot,
  stdio: 'inherit',
  shell: true,
});

if (result.error) {
  console.error(`Falha ao iniciar o Cucumber: ${result.error.message}`);
  process.exit(1);
}

process.exit(result.status === null ? 1 : result.status);
