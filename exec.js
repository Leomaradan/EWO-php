const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const allFilesRecurse = (dir) => {

    if (dir.includes('node_modules') || dir.includes('.git')) {
        return [];
    }

    const files = [];
    const items = fs.readdirSync(dir);
    for (const item of items) {
        const fullPath = path.join(dir, item);
        if (fs.statSync(fullPath).isDirectory()) {
            files.push(...allFilesRecurse(fullPath));
        } else {
            files.push(fullPath);
        }
    }
    return files;
}

const allFiles = allFilesRecurse(__dirname);



const phpFiles = allFiles.filter(file => file.endsWith('.php') || file.endsWith('.inc'));

console.log('All php files:');
//console.log(phpFiles);

for (const file of phpFiles) {
    console.log(file);
    //execSync(`dos2unix ${file}`);
}

/*for (const file of allFiles) {
    const content = fs.readFileSync(file, 'utf8');
    const index = content.indexOf('<?php');
    const lastIndex = content.lastIndexOf('<?php');

    if (lastIndex !== -1 && index !== lastIndex) {
        const newContent = content.slice(0, lastIndex);
        fs.writeFileSync(file, newContent, 'utf8');
    }
}*/



/*const updateFiles = allFiles.filter(file => file.endsWith('.js') || file.endsWith('.css') || file.endsWith('.html') || file.endsWith('.php') || file.endsWith('.inc'));
// const notUpdatedFiles = allFiles.filter(file => !updateFiles.includes(file));

console.log('All files:');
*/