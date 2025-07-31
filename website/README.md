# gsiso ai website

this is the official website for gsiso ai linux distribution. it's built with plain html and css for maximum compatibility and performance.

## Features

- **Responsive Design**: Works on all devices
- **Fast Loading**: No JavaScript required
- **Modern UI**: Clean and professional look
- **Accessibility**: Built with accessibility in mind

## Getting Started

### Prerequisites

- A web server (Apache, Nginx, etc.)
- Git (for deployment)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/gsiso-ai.git
   cd gsiso-ai/website
   ```

2. Deploy to your web server:
   - Copy all files to your web server's root directory
   - Ensure the `.htaccess` file is configured correctly (if using Apache)

### Development

1. Make your changes to the HTML and CSS files
2. Test locally by opening `index.html` in a web browser
3. Commit and push your changes

## Deployment

### Using GitHub Pages

1. Go to your repository settings on GitHub
2. Navigate to "Pages" in the left sidebar
3. Select the `main` branch and `/docs` folder
4. Click "Save"

### Using Netlify

1. Push your code to a GitHub repository
2. Log in to [Netlify](https://www.netlify.com/)
3. Click "New site from Git"
4. Select your repository and branch
5. Set the build command to `echo "No build step required"`
6. Set the publish directory to `website`
7. Click "Deploy site"

## Directory Structure

```
website/
├── index.html          # Homepage
├── css/
│   └── style.css       # Main stylesheet
├── images/             # Image assets
└── README.md           # This file
```

## Contributing

Please read [CONTRIBUTING.md](../CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the GPL-3.0 License - see the [LICENSE](../LICENSE) file for details.

## Acknowledgments

- [Font Awesome](https://fontawesome.com/) for icons
- [Google Fonts](https://fonts.google.com/) for typography
- All contributors who have helped improve this project
