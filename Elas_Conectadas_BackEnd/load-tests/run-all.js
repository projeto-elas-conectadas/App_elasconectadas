const { spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const loadTestsDir = __dirname;
const scripts = fs
  .readdirSync(loadTestsDir)
  .filter((file) => file.startsWith('load-test-') && file.endsWith('.js'))
  .sort();

if (scripts.length === 0) {
  console.error('Nenhum script load-test-*.js encontrado em load-tests/.');
  process.exit(1);
}

console.log(`Executando ${scripts.length} teste(s) k6 juntos, em sequência:\n`);
for (const script of scripts) {
  console.log(`  - ${script}`);
}
console.log('');

let failed = 0;

for (const script of scripts) {
  const scriptPath = path.join(loadTestsDir, script);
  console.log(`\n========== k6 ${script} ==========\n`);

  const result = spawnSync('k6', ['run', scriptPath], {
    stdio: 'inherit',
    shell: true,
  });

  if (result.error) {
    console.error(`Falha ao iniciar o k6 (${script}): ${result.error.message}`);
    console.error('Confirme se o k6 está instalado e no PATH.');
    failed += 1;
    continue;
  }

  if (result.status !== 0) {
    console.error(`\n${script} falhou com código ${result.status}.`);
    failed += 1;
  }
}

if (failed > 0) {
  console.error(`\n${failed} de ${scripts.length} teste(s) k6 falharam.`);
  process.exit(1);
}

console.log(`\nTodos os ${scripts.length} testes k6 concluíram com sucesso.`);
