module.exports = {
    extends: ['config:recommended'],
    allowPostUpgradeCommandTemplating: true,
    allowedPostUpgradeCommands: ['^.*'],
    repositories: ['small-hack/matrix-chart'],
    platform: 'github',
    includeForks: true,
    configMigration: true
};
