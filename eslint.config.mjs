import js from '@eslint/js';
import globals from 'globals';

export default [

    {
        ignores: [
            'node_modules/**',
            'coverage/**',
            'eslint.config.mjs'
        ]
    },

    js.configs.recommended,

    {
        languageOptions: {
            globals: {
              ... globals.node,
              ... globals.jest
            },
            
            ecmaVersion: 'latest',
            sourceType: 'commonjs'
        },

        rules: {
            semi: ['error', 'always'],
            quotes: ['error', 'single']
        }
    }
];
