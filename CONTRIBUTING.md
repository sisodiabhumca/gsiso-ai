# Contributing to Gsiso AI Linux

Thank you for your interest in contributing to Gsiso AI Linux! We welcome all contributions, whether it's code, documentation, testing, or feature suggestions.

## Table of Contents
1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Development Workflow](#development-workflow)
4. [Code Style](#code-style)
5. [Submitting Changes](#submitting-changes)
6. [Reporting Issues](#reporting-issues)
7. [Feature Requests](#feature-requests)
8. [Documentation](#documentation)
9. [Testing](#testing)
10. [Community](#community)

## Code of Conduct

This project adheres to the [Contributor Covenant](https://www.contributor-covenant.org/). By participating, you are expected to uphold this code. Please report any unacceptable behavior to [your-email@example.com].

## Getting Started

1. **Fork** the repository on GitHub
2. **Clone** your fork locally
   ```bash
   git clone https://github.com/your-username/gsiso-ai.git
   cd gsiso-ai
   ```
3. **Set up** the development environment (see [INSTALL.md](INSTALL.md))
4. **Create a branch** for your changes
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Workflow

1. **Update** your local repository
   ```bash
   git fetch origin
   git rebase origin/main
   ```
2. **Make your changes** following the code style guidelines
3. **Test** your changes thoroughly
4. **Commit** your changes with a descriptive message
   ```bash
   git commit -m "Add your commit message here"
   ```
5. **Push** to your fork
   ```bash
   git push origin feature/your-feature-name
   ```
6. **Open a Pull Request** on GitHub

## Code Style

### Shell Scripts
- Use `#!/bin/sh` for maximum compatibility
- Indent with 4 spaces (no tabs)
- Use double quotes for variable expansion
- Use `snake_case` for variables and functions
- Add comments to explain complex logic

### Commit Messages
- Use the imperative mood ("Add feature" not "Added feature")
- Keep the first line under 50 characters
- Include a blank line between the subject and body
- Reference issues and pull requests

Example:
```
Add user management script

- Add script to manage users and groups
- Include tests for user creation
- Update documentation

Fixes #123
```

## Submitting Changes

1. Ensure all tests pass
2. Update documentation as needed
3. Run the build process
4. Submit a pull request with a clear description of changes

## Reporting Issues

When reporting issues, please include:

1. Gsiso AI version (`cat /etc/gsiso-release`)
2. Steps to reproduce the issue
3. Expected behavior
4. Actual behavior
5. Relevant logs or screenshots

## Feature Requests

We welcome feature requests! Please:

1. Check if the feature has already been requested
2. Explain why this feature would be useful
3. Include any relevant use cases

## Documentation

Good documentation is crucial. When contributing:

1. Update relevant documentation
2. Follow the existing style
3. Include examples where helpful
4. Keep it concise but complete

## Testing

All contributions should include tests where applicable:

1. Unit tests for new functions
2. Integration tests for new features
3. Update existing tests if needed

## Community

Join our community:

- **Mailing List**: [link-to-mailing-list]
- **IRC**: #gsiso-ai on Libera.Chat
- **Forum**: [link-to-forum]
- **Twitter**: [@gsiso_ai]

## License

By contributing to Gsiso AI Linux, you agree that your contributions will be licensed under the [GNU General Public License v3.0](LICENSE).
