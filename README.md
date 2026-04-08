# parkNgo - Developer Documentation

Welcome to the development side of the **parkNgo** project! This document provides a simple overview of how the project is structured, what the files do, and how you can get started with development.

## 🚀 About the Project
**parkNgo** is a web platform designed to connect parking space owners with rideshare drivers (like Ola and Uber). Owners get analytics dashboards, and drivers get special parking discounts.

**Tech Stack**:
- **HTML5**: For the structure of the web pages.
- **Vanilla CSS3**: Custom styling using modern CSS features, CSS variables. No complex frameworks like Bootstrap or Tailwind are used, keeping it lightweight.
- **Icons**: FontAwesome is used for icons.

## 📁 File Organization
The project follows a very simple structure to make it easy to develop and deploy without needing a build step (like Webpack or Vite). 

```text
parkNgo-web/
│
├── assets/                  # Contains all static files like images and stylesheets
│   ├── css/
│   │   └── styles.css       # The main CSS file controlling the look of all pages
│   └── images/              # Stores pictures, logos, and graphics
│
├── index.html               # The main landing/home page of the website
├── login.html               # The central login hub where users pick their role
├── login-driver.html        # Specific login page for Ola/Uber Drivers
├── login-owner.html         # Specific login page for Parking Space Owners
├── owner-dashboard.html     # The analytics dashboard for Owners
└── driver-rewards.html      # The discounts/rewards page for Drivers
```

## 🗺️ File Mapping (What does each file do?)

Here is a breakdown of every main HTML file and its purpose:

1. **`index.html`**
   - **Role**: The main landing page.
   - **Purpose**: Welcomes users, explains what the platform does, and provides navigation to login or learn more about owner and driver features.

2. **`login.html`**
   - **Role**: The Entry Hub.
   - **Purpose**: A simple screen with two buttons allowing the user to branch out to either the Owner Login or the Driver Login.

3. **`login-owner.html` & `login-driver.html`**
   - **Role**: Authentication pages.
   - **Purpose**: Forms for users to enter their credentials depending on whether they are a space owner or a driver.

4. **`owner-dashboard.html`**
   - **Role**: Analytics Interface.
   - **Purpose**: Once an owner logs in, they see this page. It shows their parking space analytics and revenue.

5. **`driver-rewards.html`**
   - **Role**: Discounts Interface.
   - **Purpose**: Showcases driver discounts and rewards.

## 🛠️ Crucial Details for Developers

- **CSS Variables (Theming)**: The project uses CSS variables defined in `:root` inside `assets/css/styles.css`. If you want to change the primary background color, text color, or brand colors (like Cyan and Purple), you only need to change them at the top of the `styles.css` file. This ensures consistent theming.
- **No Local Server Required**: Because this is built using standard HTML and CSS, you can just double-click any `.html` file to open it directly in your browser. No Node.js or build system is strictly necessary (though using VS Code's "Live Server" extension is highly recommended for automatic reloading while developing).
- **Consistent Styles**: Many elements (like the `.glow-circle` effects) are reused across pages. Always check `styles.css` before writing new CSS to see if a utility class already exists.
- **Icons**: We are using FontAwesome via CDN. To add new icons, simply browse fontawesome.com and add the respective `<i class="fa-solid fa-..."></i>` tags to your HTML.
