#!/usr/bin/env node
'use strict';

const { execSync } = require('child_process');
const path = require('path');

const root = path.join(__dirname, '..');

try {
  if (process.platform === 'win32') {
    execSync(
      `powershell -ExecutionPolicy Bypass -File "${path.join(root, 'install.ps1')}"`,
      { stdio: 'inherit' }
    );
  } else {
    execSync(`bash "${path.join(root, 'install.sh')}"`, { stdio: 'inherit' });
  }
} catch (e) {
  process.exit(e.status || 1);
}
