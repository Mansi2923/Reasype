import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "preview", "results", "loading" ]
  
  connect() {
    console.log("Photo upload controller connected")
    console.log("Controller targets:", this.inputTarget, this.previewTarget, this.resultsTarget)
  }
  
  uploadPhoto() {
    alert("Upload function called!") // Simple test to see if this is being called
    console.log("=== UPLOAD PHOTO STARTED ===")
    const file = this.inputTarget.files[0]
    if (!file) {
      console.log("No file selected")
      return
    }
    
    console.log("File selected:", file.name, "Size:", file.size, "Type:", file.type)
    this.showPreview(file)
    this.analyzePhoto(file)
  }
  
  showPreview(file) {
    console.log("Showing preview for file:", file.name)
    const reader = new FileReader()
    reader.onload = (e) => {
      this.previewTarget.innerHTML = `
        <div class="text-center">
          <img src="${e.target.result}" class="max-w-md rounded-xl shadow-lg mx-auto">
        </div>
      `
      console.log("Preview displayed successfully")
    }
    reader.readAsDataURL(file)
  }
  
  analyzePhoto(file) {
    console.log("=== ANALYZE PHOTO STARTED ===")
    
    // Show loading state
    this.showLoading()
    
    const formData = new FormData()
    formData.append('ingredient_photo[image]', file)
    
    console.log("FormData created, sending request to /ingredient_photos")
    console.log("CSRF Token:", document.querySelector('meta[name="csrf-token"]')?.content)
    
    fetch('/ingredient_photos', {
      method: 'POST',
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    })
    .then(response => {
      console.log("=== RESPONSE RECEIVED ===")
      console.log("Response status:", response.status)
      console.log("Response headers:", response.headers)
      return response.json()
    })
    .then(data => {
      console.log("=== RESPONSE DATA ===")
      console.log("Full response data:", data)
      console.log("Success:", data.success)
      console.log("Ingredient photo:", data.ingredient_photo)
      
      this.hideLoading()
      
      if (data.success) {
        console.log("✅ Upload successful!")
        this.showMessage('✅ Image uploaded successfully!', 'success')
        console.log("About to display results:", data.ingredient_photo.recognized_ingredients)
        // Display results immediately since processing is done
        this.displayResults(data.ingredient_photo.recognized_ingredients)
      } else {
        console.error("❌ Upload failed:", data.errors)
        this.showMessage('❌ Upload failed. Please try again.', 'error')
      }
    })
    .catch(error => {
      console.error("=== FETCH ERROR ===")
      console.error("Error details:", error)
      this.hideLoading()
      this.showMessage('❌ Upload failed. Please try again.', 'error')
    })
  }
  
  showLoading() {
    console.log("Showing loading state")
    if (this.hasLoadingTarget) {
      this.loadingTarget.classList.remove('hidden')
      console.log("Loading state shown")
    } else {
      console.error("Loading target not found!")
    }
  }
  
  hideLoading() {
    console.log("Hiding loading state")
    if (this.hasLoadingTarget) {
      this.loadingTarget.classList.add('hidden')
      console.log("Loading state hidden")
    } else {
      console.error("Loading target not found!")
    }
  }
  
  displayResults(ingredients) {
    console.log("=== DISPLAY RESULTS STARTED ===")
    console.log("Raw ingredients:", ingredients)
    
    // Parse ingredients if it's a string
    if (typeof ingredients === 'string') {
      try {
        ingredients = JSON.parse(ingredients)
        console.log("Parsed ingredients from string:", ingredients)
      } catch (e) {
        console.error("Error parsing ingredients:", e)
        ingredients = []
      }
    }
    
    console.log("Final ingredients array:", ingredients)
    
    const ingredientIcons = {
      'vegetables': '🥬',
      'onions': '🧅',
      'garlic': '🧄',
      'oil': '🫒',
      'spices': '🌶️',
      'tomato': '🍅',
      'tomatoes': '🍅',
      'cheese': '🧀',
      'basil': '🌿',
      'potato': '🥔',
      'potatoes': '🥔',
      'butter': '🧈',
      'bread': '🍞',
      'rice': '🍚',
      'chicken': '🍗',
      'fish': '🐟',
      'egg': '🥚',
      'eggs': '🥚',
      'herb': '🌿',
      'sauce': '🥫',
      'beef': '🥩',
      'lettuce': '🥬',
      'onion': '🧅',
      'onions': '🧅',
      'bun': '🍞',
      'mayo': '🥫',
      'flour': '🌾',
      'milk': '🥛',
      'sugar': '🍯',
      'baking powder': '🧂',
      'protein': '🥩',
      'grains': '🌾',
      'seasonings': '🧂',
      'salt': '🧂',
      'pepper': '🌶️',
      'bell peppers': '🫑',
      'pav bread': '🍞'
    }
    
    const resultsDiv = this.resultsTarget
    console.log("Results div found:", resultsDiv)
    
    if (!resultsDiv) {
      console.error("❌ Results div not found!")
      return
    }
    
    const html = `
      <div class="bg-gradient-to-r from-green-50 to-emerald-50 rounded-xl p-6 border border-green-200">
        <h3 class="text-xl font-semibold text-gray-800 mb-4 flex items-center">
          <span class="mr-2">🔍</span>
          Recognized Ingredients
        </h3>
        <div class="flex flex-wrap gap-3">
          ${ingredients.map(ingredient => {
            const icon = ingredientIcons[ingredient.toLowerCase()] || '🥘'
            return `<span class="bg-green-100 text-green-800 px-4 py-2 rounded-full font-medium flex items-center shadow-sm">
              <span class="mr-2">${icon}</span>
              ${ingredient}
            </span>`
          }).join('')}
        </div>
        <button onclick="generateRecipes('${ingredients.join(',')}')" 
                class="mt-6 bg-gradient-to-r from-blue-500 to-blue-600 text-white px-8 py-3 rounded-xl font-semibold hover:from-blue-600 hover:to-blue-700 transition-all duration-200 transform hover:scale-105 shadow-lg">
          🍽️ Generate Recipes
        </button>
      </div>
    `
    
    console.log("Generated HTML:", html)
    resultsDiv.innerHTML = html
    console.log("✅ Results displayed successfully")
  }
  
  showMessage(message, type) {
    console.log("Showing message:", message, "Type:", type)
    const messageDiv = document.createElement('div')
    messageDiv.className = `fixed top-4 right-4 px-6 py-3 rounded-lg shadow-lg z-50 ${
      type === 'success' ? 'bg-green-500 text-white' : 'bg-red-500 text-white'
    }`
    messageDiv.textContent = message
    document.body.appendChild(messageDiv)
    
    setTimeout(() => {
      messageDiv.remove()
    }, 3000)
  }
} 