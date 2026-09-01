const { spawnSync } = require('child_process');
const path = require('path');

const backendRoot = __dirname;

function run(label, scriptPath) {
  console.log(`\n========== ${label} ==========\n`);

  const result = spawnSync('node', [scriptPath], {
    cwd: backendRoot,
    stdio: 'inherit',
    shell: true,
  });

  if (result.error) {
    console.error(`Falha ao iniciar ${label}: ${result.error.message}`);
    process.exit(1);
  }

  if (result.status !== 0) {
    console.error(
      `\n${label} falhou com código ${result.status === null ? 1 : result.status}.`,
    );
    process.exit(result.status === null ? 1 : result.status);
  }
}

console.log('Bateria SDD: Cucumber (todas as features) e k6 (todos os módulos).\n');

run('Cucumber — todas as features', path.join('features', 'run-all.js'));
run('k6 — todos os load-test-*.js', path.join('load-tests', 'run-all.js'));

console.log('\nBateria SDD completa: Cucumber e k6 concluíram com sucesso.');
