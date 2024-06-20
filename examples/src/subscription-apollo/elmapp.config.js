module.exports = {
  configureWebpack: (config, env) => {
    const newConfig = Object.assign({}, config);
    const missingRule = {
      test: /\.mjs$/,
      include: /node_modules/,
      type: 'javascript/auto',
    };
    newConfig.module.rules.push(missingRule);
    return newConfig;
  }
}
