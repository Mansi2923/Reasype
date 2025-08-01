# 🍳 Reasype - AI-Powered Recipe Optimizer

A modern Ruby on Rails application that uses **Google Cloud Vision API** to analyze ingredient photos and generate recipes. Features a beautiful, responsive UI with real-time ingredient recognition and recipe generation.

## ✨ Features

- **🔍 Real AI-Powered Ingredient Recognition**: Uses Google Cloud Vision API to extract ingredients from uploaded photos
- **📖 Recipe Generation**: Generates recipes based on recognized ingredients (currently mocked, OpenAI integration planned)
- **🎨 Modern UI/UX**: Beautiful, responsive interface with loading states, animations, and intuitive design
- **📱 Mobile-Friendly**: Optimized for mobile devices with camera capture support
- **⚡ Real-time Processing**: Immediate ingredient analysis with visual feedback
- **🎯 Smart Ingredient Filtering**: Automatically filters Vision API results for food-related labels

## 🛠️ Tech Stack

### Backend
- **Ruby on Rails 8.0.2** - Web framework
- **PostgreSQL** - Database
- **Redis** - Caching and background jobs
- **Sidekiq** - Background job processing

### Frontend
- **Tailwind CSS** - Utility-first CSS framework
- **Stimulus.js** - JavaScript framework for Rails
- **Turbo** - SPA-like experience
- **Alpine.js** - Lightweight JavaScript framework

### AI & APIs
- **Google Cloud Vision API** - Image analysis and ingredient recognition
- **Google Cloud Platform** - Cloud infrastructure and services

### Development & Deployment
- **Docker** - Containerization
- **Brakeman** - Security analysis
- **RSpec** - Testing framework

## 🚀 Quick Start

### Prerequisites
- Ruby 3.2.7+
- PostgreSQL
- Redis
- Node.js (for asset compilation)
- Google Cloud Platform account with Vision API enabled

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd reasype
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Set up the database**
   ```bash
   bundle exec rails db:create
   bundle exec rails db:migrate
   ```

4. **Install Redis** (if not already installed)
   ```bash
   # On macOS with Homebrew
   brew install redis
   brew services start redis
   ```

5. **Set up Google Cloud Vision API**
   ```bash
   # Download your service account JSON key
   # Place it in config/movielistapp-27e91-a5f011d6abb0.json
   
   # Set environment variable
   export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/reasype/config/movielistapp-27e91-a5f011d6abb0.json"
   ```

6. **Enable billing in Google Cloud Console**
   - Go to [Google Cloud Console](https://console.cloud.google.com)
   - Enable billing for your project
   - Enable the Vision API

7. **Start the development server**
   ```bash
   bundle exec rails server
   ```

8. **Start Sidekiq for background jobs** (in a separate terminal)
   ```bash
   bundle exec sidekiq
   ```

9. **Visit the application**
   ```
   http://localhost:3000
   ```

## 📱 Usage

1. **Upload an Image**: Click "Choose Image" to upload a photo of your ingredients
2. **AI Analysis**: The app uses Google Vision API to recognize ingredients in your photo
3. **View Results**: See recognized ingredients displayed as beautiful green tags with icons
4. **Generate Recipes**: Click "Generate Recipes" to create recipes based on your ingredients
5. **Save & Share**: Copy or save recipes to your collection

## 🔧 API Endpoints

- `POST /ingredient_photos` - Upload ingredient photos
- `GET /ingredient_photos/:id` - Get photo analysis results
- `POST /recipes/generate` - Generate recipes from ingredients
- `POST /recipes/save` - Save generated recipes
- `GET /recipes/:id` - View a specific recipe

## 🏗️ Architecture

### Services
- `IngredientRecognitionService` - Handles Google Vision API integration
- `RecipeGeneratorService` - Generates recipes (currently mocked, OpenAI planned)

### Background Jobs
- `AnalyzeIngredientsJob` - Processes ingredient photos for recognition
- `TimerJob` - Handles cooking timers and notifications

### Models
- `User` - User accounts and preferences
- `IngredientPhoto` - Uploaded photos and analysis results
- `Recipe` - Generated recipes
- `CookingSession` - Active cooking sessions with timers

## 🧪 Testing

```bash
# Run all tests
bundle exec rails test

# Run specific test files
bundle exec rails test test/services/recipe_generator_service_test.rb
```

## 🔒 Security

- **Brakeman** integration for security analysis
- **CSRF protection** enabled
- **Secure file uploads** with validation
- **Environment variable** management for API keys

## 🚀 Deployment

### Render Deployment
This application is deployed on **Render** for production hosting.

### Production Setup
1. Set up production environment variables on Render
2. Configure Redis for production
3. Set up SSL for secure connections
4. Configure image storage (AWS S3 recommended)
5. Set up monitoring and logging

### Environment Variables
```bash
GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json
RAILS_ENV=production
DATABASE_URL=postgresql://...
REDIS_URL=redis://...
```

## 🔮 Future Enhancements

### Planned Features
- **OpenAI Integration** - Real AI-powered recipe generation
- **Recipe Rating System** - User reviews and ratings
- **Meal Planning Calendar** - Weekly meal planning
- **Shopping List Generation** - Automatic shopping lists
- **Nutritional Analysis** - Calorie and nutrition tracking
- **Social Sharing** - Share recipes on social media
- **Voice Commands** - Hands-free cooking assistance

### UI/UX Improvements
- **Dark Mode** - Toggle between light and dark themes
- **Recipe Collections** - Organize recipes into collections
- **Advanced Filtering** - Filter by cuisine, difficulty, time
- **Recipe Scaling** - Adjust serving sizes automatically

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Google Cloud Vision API** for image analysis
- **Tailwind CSS** for the beautiful UI components
- **Rails community** for the excellent framework
- **OpenAI** (planned integration) for recipe generation

---

**Made with ❤️ for food lovers everywhere**
