#SOURCE ARTICLE

- [leandroluk/How to start monorepo with NextJS + NestJS using pnpm workspaces](https://gist.github.com/leandroluk/ead95513d3666326d364248ae98eb2e3)

# Dependencies

- [Microsoft VS Code](https://code.visualstudio.com/download)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Docker Compose](https://docs.docker.com/compose/)
- [NodeJS (LTS)](https://nodejs.org/en/download/package-manager)
- [PNPM](https://pnpm.io)
- [Git](https://www.git-scm.com/downloads)
- [GitFlow](https://github.com/nvie/gitflow)

## Tips

- Before install NodeJS, you can install PNPM using the commmand:

  ```sh
  $ npm add -g pnpm
  ```

  > **Note**: PNPM is a fast, disk space efficient package manager (better than npm)

- You can install git + gitflow on windows using Chocolatey with command:

  ```sh
  $ choco install git.install git-flow-hooks
  ```

# Steps

## Instalation and minimal config

### Initializing and configuring GIT

- Open project directory and in terminal and initialize git + gitflow (with default convention branch names) with command:

  ```sh
  $ git init && git flow init -d
  ```

- Create `.gitignore` file:

  ```
  node_modules
  dist
  ```

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: initializing git"
  ```

### Setup IDE and pnpm project

- Run command to start project:

  ```sh
  $ pnpm init
  ```

- Create `.vscode/settings.json` file to create a minimal configuration of IDE

  ```json
  {
    // editor
    "editor.formatOnPaste": true,
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    "editor.detectIndentation": false,
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit",
      "source.organizeImports": "explicit"
    },
    "editor.rulers": [80, 100, 120],
    // files
    "files.encoding": "utf8",
    "files.eol": "\n",
    "files.insertFinalNewline": false,
    "files.trimFinalNewlines": true,
    "files.associations": {
      ".env*": "shellscript"
    },
    // docker
    "[dockercompose]": {
      "editor.formatOnSave": false
    },
    // git
    "git.inputValidation": false,
    // jestrunner
    "jestrunner.runOptions": ["--testTimeout=999999"],
    // javascript
    "javascript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces": false,
    "javascript.format.insertSpaceAfterFunctionKeywordForAnonymousFunctions": false,
    "javascript.format.insertSpaceAfterOpeningAndBeforeClosingEmptyBraces": false,
    "javascript.format.insertSpaceBeforeFunctionParenthesis": false,
    "javascript.preferences.importModuleSpecifier": "shortest",
    "javascript.preferences.quoteStyle": "single",
    // typescript
    "typescript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces": false,
    "typescript.format.insertSpaceAfterFunctionKeywordForAnonymousFunctions": false,
    "typescript.format.insertSpaceAfterOpeningAndBeforeClosingEmptyBraces": false,
    "typescript.format.insertSpaceBeforeFunctionParenthesis": false,
    "typescript.preferences.importModuleSpecifier": "shortest",
    "typescript.preferences.quoteStyle": "single",
    // xml
    "xml.format.enabled": false,
    // css
    "css.lint.unknownAtRules": "ignore"
  }
  ```

- Create `.vscode/extensions.json` file to ensure user to install or remove extensions to
  better experience on project:

  ```json
  {
    "recommendations": [
      // to run jest tests clicking directly on file
      "firsttris.vscode-jest-runner",
      // beautyfull icons
      "vscode-icons-team.vscode-icons",
      // eslint formatter
      "dbaeumer.vscode-eslint",
      // sonarlint codesmell check
      "SonarSource.sonarlint-vscode",
      // to ensure produtivity
      "eamodio.gitlens",
      // to better integration with docker
      "ms-azuretools.vscode-docker",
      // to better experience on writing .prisma files
      "Prisma.prisma",
      // to better experience using tailwindcss on frontend (default css library on NextJS)
      "bradlc.vscode-tailwindcss",
      // to use the most common IDE configurator and grant some config's in other IDE's
      "EditorConfig.EditorConfig"
    ],
    "unwantedRecommendations": [
      // this extension will conflict with the default eslint extension
      "esbenp.prettier-vscode"
    ]
  }
  ```

- Create `pnpm-workspace.yaml` file with content:

  ```yaml
  packages:
    - 'packages/*'
    - 'apps/*'
  ```

- Create files `apps/.gitkeep` and `packages/.gitkeep`. This files will be used to maintain this directories on project. The directories will be used to:

  - **apps**: all artfacts compound the solution
  - **packages**: all shared types, components or functions used in more than one artfact

- Update `package.json` like this:

  ```json
  {
    "private": true,
    "name": "my-project-name",
    "displayName": "My project name",
    "description": "A simple description about the project",
    "version": "0.1.0",
    "homepage": "PROJECT_GIT_REPOSITORY_URL",
    "license": "UNLICENSED",
    "author": {
      "name": "You own name",
      "email": "you@email.com",
      "url": "https://www.linkedin.com/in/MY_LINKEDIN_PAGE_URL"
    }
  }
  ```

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configuring project and IDE"
  ```

### Create NextJS project with minimal configuration

- Create NextJS project with command:

  ```sh
  $ pnpm create next-app apps/web
  ```

  > ⚠️ **NOTE**: by some reason when install NextJS in pnpm workspace and try to build this isn't working well.
  > The solution is navigate into `apps/web` directory and run the command `pnpm update --force`. Before this the
  > `build` command will works again.

  You will see a list of questions. Respond like this:

  - Would you like to use TypeScript? No / <u>**Yes**</u>
  - Would you like to use ESLint? No / <u>**Yes**</u>
  - Would you like to use Tailwind CSS? No / <u>**Yes**</u>
  - Would you like to use `src/` directory? No / <u>**Yes**</u>
  - Would you like to use App Router? (recommended) No / <u>**Yes**</u>
  - Would you like to customize the default import alias (@/\*)? No / <u>**Yes**</u>
  - What import alias would you like configured? <u>**#/\***</u>

- Edit `apps/web/package.json` file, changing the script "dev" like this:

  ```json
  {
    "scripts": {
      "dev": "next dev -p 3001"
    }
  }
  ```

- Navigate to `web` and check if project it working with command:

  ```sh
  $ pnpm dev # check on url http://localhost:3001
  ```

- Update `apps/web/package.json` like this

  ```json
  {
    "private": true,
    "name": "@{{ROOT_PROJECT_NAME}}/web",
    "displayName": "{{ROOT_PROJECT_DISPLAY_NAME}} - Frontend application using NextJS",
    "description": "{{PROJECT_MINIMAL_DESCRIPTION}}",
    "version": "0.1.0",
    "license": "UNLICENSED",
    "author": {
      "name": "Leandro S. Gomes",
      "email": "leandroluk@gmail.com",
      "url": "https://www.linkedin.com/in/leandroluk"
    }
  }
  ```

- Update again `apps/web/package.json` adding "compile" script

  ```json
  {
    "scripts": {
      "compile": "tsc --noEmit"
    }
  }
  ```

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: create web project"
  ```

### Create NestJS project with minimal configuration

- Create NestJS project with command:

  ```sh
  $ pnpx @nestjs/cli new apps/api -p pnpm
  ```

- Remove `apps/api/.git` directory (NestJS by default creates the .git directory) with command

  ```sh
  $ pnpx rimraf apps/api/.git
  ```

- Edit `apps/api/package.json` file, changing script "start:dev" into "dev"
  and removing scripts `format`, `start:debug`, `start:prod`, `test:*`,

- Remove the file `apps/api/test/jest-e2e.json`. We will configure jest before for all projects and what NestJS calls e2e actually needs to be an integration test mocking external dependencies like databases, etc.

- Navigate to `api` and check if project it working with command:

  ```sh
  $ pnpm dev # check on url http://localhost:3000
  ```

- Update `apps/api/package.json` like this

  ```json
  {
    "private": true,
    "name": "@{{ROOT_PROJECT_NAME}}/api",
    "displayName": "{{ROOT_PROJECT_DISPLAY_NAME}} - Backend application using NestJS",
    "description": "{{PROJECT_MINIMAL_DESCRIPTION}}",
    "version": "0.1.0",
    "license": "UNLICENSED",
    "author": {
      "name": "Leandro S. Gomes",
      "email": "leandroluk@gmail.com",
      "url": "https://www.linkedin.com/in/leandroluk"
    }
  }
  ```

- Update again `apps/web/package.json` adding "compile" script

  ```json
  {
    "scripts": {
      "compile": "tsc --noEmit"
    }
  }
  ```

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: create api project"
  ```

### Create domain package to share types and stuff

- Create `packages/domain` directory and navigate into it.

- Create new project with command:

  ```
  $ pnpm init
  ```

- Update `packages/domain/package.json` like this

  ```json
  {
    "private": true,
    "name": "@{{ROOT_PROJECT_NAME}}/domain",
    "displayName": "{{ROOT_PROJECT_DISPLAY_NAME}} - Domain layer",
    "description": "{{PROJECT_MINIMAL_DESCRIPTION}}",
    "version": "0.1.0",
    "license": "UNLICENSED",
    "author": {
      "name": "Leandro S. Gomes",
      "email": "leandroluk@gmail.com",
      "url": "https://www.linkedin.com/in/leandroluk"
    }
  }
  ```

- Install typescript and configure with command

  ```sh
  $ pnpm add -D typescript && pnpm exec tsc --init
  ```

- Update `packages/domain/tsconfig.json` like this

  ```json
  {
    "compilerOptions": {
      "target": "ESNext",
      "module": "CommonJS",
      "strict": true,
      "outDir": "dist",
      "rootDir": "./src",
      "declaration": true,
      "baseUrl": "./",
      "paths": { "#/*": ["./src/*"] }
    },
    "exclude": ["node_modules", "dist/**/*"]
  }
  ```

- Create `packages/domain/src/index.ts` file for test integration in apps:

  ```ts
  export const sum = (a: number, b: number) => a + b;
  ```

- Update `packages/domain/package.json` adding reference to add minimal scripts and export all files in "dist" and

  ```json
  {
    "main": "dist/index.js",
    "types": "dist/index.d.ts",
    "scripts": {
      "build": "tsc",
      "compile": "tsc --noEmit"
    }
  }
  ```

- Run `build` script to generate distribuction code of domain package

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: create domain package"
  ```

### Integrate domain package into "web" and "api" apps

- Navigate to `apps/api` and `apps/web` and run the command

  ```sh
  $ pnpm add @monorepo/domain -w
  ```

- Change `apps/api/src/app.service.ts` to use the `domain` package like this:

  ```ts
  import { Injectable } from '@nestjs/common';
  import { sum } from '@monorepo/domain';

  @Injectable()
  export class AppService {
    getHello(): string {
      return 'Hello World! ' + sum(2, 2);
    }
  }
  ```

- Test project again running `dev` command and check it in url https://localhost:3000

- Now change `apps/web/src/page.tsx` like this

  ```tsx
  import { sum } from '@monorepo/domain';

  export default function IndexPage() {
    return <div>Hello World! {sum(2, 2)}</div>;
  }
  ```

- Test project again running `dev` command and check it in url https://localhost:3001

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: finish integration between api, domain and web"
  ```

### Configure global debug, validation and linting

- In each artfact inner `apps` verify if it contains script below:

  ```json
  {
    "scripts": {
      "compile": "tsc --noEmit"
    }
  }
  ```

  This is a method to fast verify if are some problem with typescript

- In global `package.json` add the scripts below

  ```json
  {
    "scripts": {
      "dev": "pnpm --parallel -r run dev",
      "tsc": "pnpm --parallel -r run tsc",
      "lint": "pnpm --parallel -r run lint",
      "build": "pnpm --parallel -r run build"
    }
  }
  ```

  Now we can start any common script bettween artfacts `pnpm dev` in parallel.

- Create the file `.vscode/launch.json` like this:

  ```json
  {
    "version": "0.2.0",
    "configurations": [
      // dev:api
      {
        "name": "dev:api",
        "request": "launch",
        "type": "node",
        "cwd": "${workspaceFolder}/apps/api",
        "runtimeExecutable": "npm",
        "runtimeArgs": ["run-script", "dev"],
        "skipFiles": ["<node_internals>/**"]
      },
      // dev:web:server
      {
        "name": "dev:web:server",
        "type": "node-terminal",
        "cwd": "${workspaceFolder}/apps/web",
        "request": "launch",
        "command": "npm run dev"
      },
      // dev:web:client
      {
        "name": "dev:web:client",
        "type": "chrome",
        "request": "launch",
        "url": "http://localhost:3001"
      },
      // dev:web
      {
        "name": "dev:web",
        "type": "node-terminal",
        "request": "launch",
        "cwd": "${workspaceFolder}/apps/web",
        "command": "npm run dev",
        "serverReadyAction": {
          "pattern": "- Local:.+(https?://.+)",
          "uriFormat": "%s",
          "action": "debugWithChrome"
        }
      },
      // dev:server
      {
        "name": "dev",
        "request": "launch",
        "type": "node",
        "runtimeExecutable": "npm",
        "runtimeArgs": ["run-script", "dev"],
        "skipFiles": ["<node_internals>/**"]
      },
      // dev
      {
        "name": "dev",
        "request": "launch",
        "type": "node",
        "runtimeExecutable": "npm",
        "runtimeArgs": ["run-script", "dev"],
        "serverReadyAction": {
          "pattern": "- Local:.+(https?://.+)",
          "uriFormat": "%s",
          "action": "debugWithChrome"
        },
        "skipFiles": ["<node_internals>/**"]
      }
    ],
    "compounds": []
  }
  ```

  This file will configure some options to debug:

  - **dev:api**: to start `dev` script in api (NestJS)
  - **dev:web:server**: to start `dev` script in web (NextJS) but without open dedicated chrome
  - **dev:web:client**: to start only dedicated chrome looking for web (NextJS)
  - **dev:server**: to start `dev` in both projects (api and web) without dedicated chrome
  - **dev**: to start `dev` in both projects with dedicated chrome

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configure global scripts and debug"
  ```

### Adding docker compose to api and global

- Create `apps/api/docker-compose.yml` file like this:

  ```yaml
  name: monorepo
  networks:
    monorepo:
      name: monorepo
  services:
    monorepo-postgres:
      image: postgres
      hostname: postgres
      container_name: monorepo-postgres
      ports: ['${POSTGRES_PORT:?}:5432']
      volumes: ['monorepo-postgres:/var/lib/postgresql/data']
      networks: ['monorepo']
      environment:
        POSTGRES_USER: ${POSTGRES_USER:?}
        POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:?}
        POSTGRES_DB: ${POSTGRES_DB:?}
      healthcheck:
        test: ['CMD-SHELL', 'pg_isready -U postgres']
        interval: 10s
        timeout: 5s
        start_period: 10s
  volumes:
    monorepo-postgres:
  ```

- Change `apps/api/package.json` file adding the scripts:

  ```json
  {
    "scripts": {
      "compose": "docker-compose down --remove-orphans && docker-compose up --build --force-recreate",
      "compose:d": "npm run compose -- -d"
    }
  }
  ```

- Create `docker-compose.yml` file like this:

  ```yaml
  name: monorepo
  networks:
    monorepo:
      name: monorepo
  services:
    monorepo-postgres:
      extends:
        file: apps/api/docker-compose.yml
        service: monorepo-postgres
  volumes:
    monorepo-postgres:
  ```

- Change `package.json` file adding the scripts:

  ```json
  {
    "scripts": {
      "compose": "docker-compose down --remove-orphans && docker-compose up --build --force-recreate",
      "compose:d": "npm run compose -- -d"
    }
  }
  ```

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configure docker compose to api and global"
  ```

### Add commitlint, lefthook and configure in monorepo

- Install dependencies in workspace:

  ```sh
  $ pnpm add -D -w @commitlint/cli @commitlint/config-conventional commitlint cz-conventional-changelog lefthook
  ```

- Edit `package.json` file adding commitlint configuration like this:

  ```json
  {
    "scripts": {
      // ...
    },
    "commitlint": {
      "extends": ["@commitlint/config-conventional"]
    },
    "dependencies": {
      /// ...
    }
  }
  ```

- Will be created a file called `lefthook.yml`. Change the content like this

  ```yaml
  # https://github.com/evilmartians/lefthook/blob/master/docs/configuration.md
  commit-msg:
    commands:
      commitlint:
        run: pnpx commitlint --edit # https://commitlint.js.org
  pre-commit:
    parallel: true
    commands:
      validate:
        run: pnpm lint && pnpm tsc && pnpm build
  ```

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configure commitlint, lefthook and configure this in monorepo"
  ```

## Change projects to include GTS (Google Typescript Style)

### Install and config in monorepo

- In root project run the command

  ```sh
  $ pnpx gts init
  ```

  The command will ask some questions about replacing files, do not accept the replacements. Before this run this command:

  ```sh
  $ pnpm update --force
  ```

- In `package.json` remove any script containing `gts` in the command and the scripts called `prepare`, `pretest` and `posttest`. We don't need this scripts (do this for each project).

- Change the `.eslintignore` files. change it like this:

  ```
  dist/
  node_modules/
  .next/
  ```

- Delete the `.eslintrc.json`. We will use this file in each project, not on the root directory

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configure gts to monorepo"
  ```

### Install and config apps/api

- In `apps/api` run the command

  ```sh
  $ pnpx gts init
  ```

  The command will ask some questions about replacing files, do not accept the replacements. Before this run this command:

  ```sh
  $ pnpm update --force
  ```

  It will force pnpm to put the gts directory in each project, required for found configuration files.

- In `apps/api/package.json` remove any script containing `gts` in the command and the scripts called `prepare`, `pretest` and `posttest`. We don't need this scripts (do this for each project).

- Change the `apps/web/.eslintignore` files. change it like this:

  ```
  dist/
  node_modules/
  ```

- Removing the `apps/web/.editorconfig` file. This file only is necessary on the root project and the monorepo uses root created file.

- Delete the `apps/api/.eslintrc.json` file and change the `apps/api/.eslintrc.js` to this:

  ```js
  module.exports = {
    "root": true,
    "parser": "@typescript-eslint/parser",
    "parserOptions": {
      "project": "tsconfig.json",
      "tsconfigRootDir": __dirname,
      "sourceType": "module"
    },
    "plugins": [
      "@typescript-eslint/eslint-plugin"
    ],
    "extends": [
      "plugin:@typescript-eslint/recommended",
      "plugin:prettier/recommended",
      "./node_modules/gts/"
    ],
    "env": {
      "node": true,
      "jest": true
    },
    "ignorePatterns": [
      ".eslintrc.js"
    ],
    "rules": {
      // * @typescript-eslint
      "@typescript-eslint/no-namespace": "off",
      "@typescript-eslint/no-explicit-any": "off",
      "@typescript-eslint/consistent-type-definitions": ["error","type"],
      "@typescript-eslint/consistent-type-imports": ["error",{"prefer":"no-type-imports"}],
      "@typescript-eslint/no-unused-vars": [
        "error",
        {
          "argsIgnorePattern": "^_",
          "varsIgnorePattern": "^_",
          "caughtErrorsIgnorePattern": "^_"
        }
      ],
      "@typescript-eslint/explicit-function-return-type": "off",
      "@typescript-eslint/explicit-module-boundary-types": "off"
    },
    "settings": {
      "node": {
        "allowModules": ["@nestjs/testing","supertest"]
      }
    }
  };
  ```

- Run the command `pnpm lint` in `apps/api` directory and fix any error found.

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configure gts to apps/api"
  ```

### Install and config apps/web

- In `apps/web` run the command

  ```sh
  $ pnpx gts init
  ```

  The command will ask some questions about replacing files, do not accept the replacements. Before this run this command:

  ```sh
  $ pnpm update --force
  ```

  It will force pnpm to put the gts directory in each project, required for found configuration files.

- In `apps/web/package.json` remove any script containing `gts` in the command and the scripts called `prepare`, `pretest` and `posttest`. We don't need this scripts (do this for each project).

- Change the `apps/web/.eslintignore` files. change it like this:

  ```
  dist/
  node_modules/
  .next/
  ```

- Removing the `apps/web/.editorconfig` file. This file only is necessary on the root project and the monorepo uses root created file.

- Edit the `apps/api/.prettierrc.js` file like this

  ```js
  module.exports = {
    ...require('../../.prettierrc.js'),
    printWidth: 120
  };
  ```

  > **Note**: this is optional, I like to work with 120 max width scripts but prettier uses 80 by default

- Rename the file `apps/web/.eslintrc.json` to `apps/web/.eslintrc.js` and change it like this:

  ```js
  module.exports = {
    "root": true,
    "extends": ["./node_modules/gts/", "next/core-web-vitals"],
    "rules": {
      // * @typescript-eslint
      "@typescript-eslint/no-namespace": "off",
      "@typescript-eslint/no-explicit-any": "off",
      "@typescript-eslint/consistent-type-definitions": ["error","type"],
      "@typescript-eslint/consistent-type-imports": ["error",{"fixStyle": "inline-type-imports"}],
      // * import
      "import/no-duplicates": "off",
      // * vanilla
      "prefer-arrow-callback": ["error",{"allowNamedFunctions": true}]
    },
    "settings": {
      "node": {
        "allowModules": [
          "@jest/types",
          "@testing-library/jest-dom",
          "@testing-library/react",
          "tailwindcss"
        ]
      }
    }
  };

  ```

- Run the command `pnpm lint` on `apps/web` folder, it will fail needing to change the files `apps/web/src/app/{layout,page}.tsx`. Change these files like this

  ```tsx
  // src/app/layout.tsx
  import { type Metadata } from 'next';
  import { Inter } from 'next/font/google';
  import { type FC, type PropsWithChildren } from 'react';
  import './globals.css';

  const inter = Inter({ subsets: ['latin'] });

  export const metadata: Metadata = {
    title: 'Create Next App',
    description: 'Generated by create next app',
  };

  const RootLayout: FC<PropsWithChildren> = ({ children }) => {
    return (
      <html lang="en">
        <body className={inter.className}>{children}</body>
      </html>
    );
  };

  export default RootLayout;
  ```

  ```tsx
  // src/app/page.tsx
  import { sum } from '@monorepo/domain';
  import { type FC } from 'react';

  const IndexPage: FC = () => {
    return <div>Hello World! {sum(2, 2)}</div>;
  };

  export default IndexPage;
  ```

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configure gts to apps/web"
  ```

### Install and config packages/domain

- In `packages/domain` run the command

  ```sh
  $ pnpx gts init
  ```

  The command will ask some questions about replacing files, do not accept the replacements. Before this run this command:

  ```sh
  $ pnpm update --force
  ```

- In `packages/domain/package.json` remove any script containing `gts` in the command and the scripts called `prepare`, `pretest` and `posttest`. We don't need this scripts (do this for each project).

- Change the script `lint` in `packages/domain/package.json` like this

  ```json
  {
    "scripts": {
      "lint": "gts lint -- --fix"
    }
  }
  ```

- Change the `packages/domain/.eslintignore` files. change it like this:

  ```
  dist/
  node_modules/
  ```

- Removing the `packages/domain.editorconfig` file. This file only is necessary on the root project and the monorepo uses root created file.

- Edit the `packages/domain/.prettierrc.js` file like this

  ```js
  module.exports = {
    ...require('../../.prettierrc.js'),
  };
  ```

  > **Note**: this is optional, I like to work with 120 max width scripts but prettier uses 80 by default

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configure gts to packages/domain"
  ```

## Configure tests (accepting `.test` and `.spec` files)

### Change apps/api

In backend, we can separate tests in 2 types:

- **unit tests**: using the `*.spec.ts` postfixes and testing each method apart, mocking any dependency of them.

- **integration tests**: using the `*.test.ts` postfixes and testing all the layers over application, mocking any external dependency like databases. This is necessary to improve the speed of tests and maintain better control over all alternative ways for each use case.

- Install the `@jest/types` as dev dependency to `apps/api` project:

  ```sh
  $ pnpm add -D @jest/types
  ```

- Create the files below in `apps/api` file like this

  > apps/api/jest.config.ts

  ```ts
  import { Config } from '@jest/types';

  const config: Config.InitialOptions = {
    moduleFileExtensions: ['js', 'json', 'ts'],
    roots: ['<rootDir>/src'],
    testRegex: ['.*.spec.ts$', '.*.test.ts$'],
    transform: {
      '^.+\\.(t|j)s$': 'ts-jest',
    },
    collectCoverageFrom: ['**/src/*.(t|j)s'],
    coverageDirectory: '.tmp/coverage',
    testEnvironment: 'node',
  };

  export default config;
  ```

  > apps/api/jest.unit.config.ts

  ```ts
  import config from './jest.config';

  config.collectCoverageFrom = [
    '<rootDir>/src/data/**/*.ts',
    '<rootDir>/src/infra/**/*.ts',
    '<rootDir>/src/presentation/**/*.ts',
  ];
  config.testMatch = ['**/*.spec.ts'];

  export default config;
  ```

  > apps/api/jest.integration.config.ts

  ```ts
  import config from './jest.config';

  config.collectCoverageFrom = ['<rootDir>/src/main/**/*.ts'];
  config.testMatch = ['**/*.test.ts'];

  export default config;
  ```

- Remove the property `jest` from `apps/api/package.json` and add scripts below

  ```json
  {
    "scripts": {
      "test": "jest",
      "test:ci": "jest --coverage"
    }
  }
  ```

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configure tests in apps/api"
  ```

### Change apps/web

In frontend, we can separate tests in 2 types:

- **unit tests**: using the `*.spec.tsx` postfixes and testing component apart, mocking any dependency of them.
- **integration tests**: using the `*.test.tsx` postfixes plus some automation tool like (Cypress)[https://www.cypress.io/] or [Playwright](https://playwright.dev/) to open application in browser, mocking any external dependency. This is necessary to improve the speed of tests and maintain better control over all alternative ways for each use case.

- Install test dependencies to run tests

  ```sh
  $ pnpm add -D @jest/types @testing-library/jest-dom @testing-library/react @types/jest @types/supertest jest jest-environment-jsdom supertest ts-jest
  ```

- Create the files below:

  > apps/web/jest.config.ts

  ```ts
  import { type Config } from '@jest/types';
  import nextJest from 'next/jest.js';

  const createJestConfig = nextJest({ dir: './' });

  const config: Config.InitialOptions = {
    preset: 'ts-jest',
    roots: ['<rootDir>/src', '<rootDir>/tests'],
    setupFilesAfterEnv: ['<rootDir>/jest.setup.ts'],
    coverageDirectory: '.tmp/coverage',
    collectCoverageFrom: ['<rootDir>/src/**/*.ts', '<rootDir>/src/**/*.tsx'],
    testEnvironment: 'jsdom',
    testMatch: ['**/*.spec.ts', '**/*.spec.tsx', '**/*.test.ts', '**/*.test.tsx'],
    testPathIgnorePatterns: ['/node_modules/'],
    moduleNameMapper: {
      'package.json': '<rootDir>/package.json',
      '[#]/(.*)': '<rootDir>/src/$1',
    },
  };

  export default createJestConfig(config);
  ```

  > apps/web/jest.unit.config.ts

  ```ts
  import nextJest from 'next/jest.js';
  import { config } from './jest.config';

  const createJestConfig = nextJest({ dir: './' });

  config.testMatch = ['**/*.spec.ts'];

  export default createJestConfig(config);
  ```

  > apps/web/jest.integration.config.ts

  ```ts
  import nextJest from 'next/jest.js';
  import { config } from './jest.config';

  const createJestConfig = nextJest({ dir: './' });

  config.testMatch = ['**/*.test.ts'];

  export default createJestConfig(config);
  ```

  > apps/web/jest.setup.ts

  ```ts
  import '@testing-library/jest-dom';
  import '@testing-library/react';

  Object.defineProperty(window, 'matchMedia', {
    writable: true,
    value: jest.fn().mockImplementation(query => ({
      matches: false,
      media: query,
      onchange: null,
      addListener: jest.fn(), // Deprecated but added for compatibility
      removeListener: jest.fn(), // Deprecated but added for compatibility
      addEventListener: jest.fn(),
      removeEventListener: jest.fn(),
      dispatchEvent: jest.fn(),
    })),
  });

  // this is an example
  global.console = {
    log: jest.fn(),
    error: jest.fn(),
    warn: jest.fn(),
  } as unknown as Console;
  ```

- Add scripts to `apps/web/package.json`

  ```json
  {
    "scripts": {
      "test": "jest --passWithNoTests --runInBand --detectOpenHandles --silent --noStackTrace",
      "test:v": "jest --passWithNoTests --runInBand --detectOpenHandles --verbose",
      "test:w": "npm run test -- --watch",
      "test:ci": "npm run test -- --coverage",
      "test:staged": "npm test -- --findRelatedTests"
    }
  }
  ```

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configure tests in apps/web"
  ```

### Add the tests into monorepo

- Change the `package.json` adding script to run tests

  ```json
  {
    "scripts": {
      "test": "pnpm --parallel -r run test",
      "test:ci": "pnpm --parallel -r run test:ci"
    }
  }
  ```

- Do commit:

  ```sh
  $ git add . && git commit -m "chore: configure tests in monorepo"
  ```

Now we can start develop the project using the conventions over NestJS, NextJS and to create packages