// eslint-disable-next-line import/no-extraneous-dependencies
const chokidar = require('chokidar');
const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

let ready = false;

async function buildVue() {
    try {
        // execSync('git submodule update --init --remote', { cwd: process.cwd() });
        const packageJsonPath = path.join(process.cwd(), 'cv-frontend-vue', 'package.json');
        const packageLockJsonPath = path.join(process.cwd(), 'cv-frontend-vue', 'package-lock.json');

        if (fs.existsSync(packageJsonPath) && fs.existsSync(packageLockJsonPath)) {
            execSync('npm install', { cwd: path.join(process.cwd(), 'cv-frontend-vue') });
            execSync('npm run build', { cwd: path.join(process.cwd(), 'cv-frontend-vue') });
        } else {
            throw new Error('package.json or package-lock.json is not found inside submodule directory');
        }
    } catch (err) {
        // eslint-disable-next-line no-console
        console.error(`Error building Vue simulator: ${new Date(Date.now()).toLocaleString()}\n\n${err}`);
        process.exit(1);
    }
}

chokidar.watch('cv-frontend-vue', {
    ignored: /(^|[\/\\])node_modules([\/\\]|$)/, 
    persistent: true
})
.on('ready', () => ready = true)
.on('all', async(event, path)=>{
    if (!ready) return;
    await buildVue();
})
