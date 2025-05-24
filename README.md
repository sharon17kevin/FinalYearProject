# AgriAdvisor: AI-Powered Crop Rotation Planning
AgriAdvisor is an intelligent decision support system that provides data-driven crop rotation recommendations to optimize agricultural practices. By leveraging a Random Forest machine learning model and analyzing key soil parameters, this tool helps farmers enhance soil health, improve crop yields, and promote long-term sustainability in farming.

## Overview
Crop rotation plays a crucial role in maintaining soil health and boosting crop yield. The system leverages soil data to generate rotation recommendations, guiding farmers in choosing crop sequences that optimize soil quality and reduce resource depletion.

## Features
- **Data-Driven Recommendations:** Suggests ideal crop rotations tailored to specific soil conditions. By considering specific soil composition (like N, P, K levels, pH) and climate data, the system helps maximize nutrient utilization, reduce the likelihood of crop diseases, and ultimately increase yield.
- **Random Forest Model:** Utilizes a machine learning model to analyze soil parameters and historical crop data for predictions. This model is chosen for its accuracy in handling complex, non-linear agricultural datasets and providing robust predictions for crop suitability and rotation efficacy.
- **User-Friendly Interface:** Allows easy input of soil parameters to receive crop rotation recommendations. This enables farmers to quickly input their field data and receive actionable insights without needing extensive technical knowledge or complex data interpretation.
- **Sustainable Agriculture Support:** Promotes soil health and minimizes environmental impacts through optimized crop choices. This approach fosters environmentally friendly farming by reducing the reliance on chemical fertilizers and pesticides, improving long-term soil fertility, and enhancing local biodiversity.

## How it Works
AgriAdvisor combines a user-friendly interface with a powerful machine learning backend to deliver crop rotation advice:
-   **User Input:** Farmers input key soil parameters such as Nitrogen (N), Phosphorus (P), Potassium (K) levels, pH, local rainfall, temperature, and humidity through the application.
-   **AI-Powered Analysis:** This data is sent to a Python-based backend. Here, a Random Forest machine learning model processes the input, analyzing it against historical agricultural data and soil science principles to evaluate potential crop sequences.
-   **Rotation Recommendation:** The system then recommends an optimal crop rotation plan, tailored to the specific conditions provided, aiming to improve soil fertility and crop output.

## Getting Started
To get a local copy up and running, follow these simple steps.

### Prerequisites
Ensure you have the following software and tools installed:
-   **Flutter SDK:** Latest stable version recommended. [Installation Guide](https://flutter.dev/docs/get-started/install)
-   **Python:** Python 3.8+ recommended. [Download Python](https://www.python.org/downloads/)
-   **Pip:** Python package installer (usually comes with Python).
-   **Git:** For cloning the repository. [Download Git](https://git-scm.com/downloads)

### Frontend (Flutter Application)
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/final_project.git 
    ```
    (Replace with the actual repository URL)
2.  **Navigate to the project directory:**
    ```bash
    cd final_project 
    ```
    (Or the correct project root folder name)
3.  **Install Flutter dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the application:**
    ```bash
    flutter run
    ```
    Ensure you have an emulator running or a device connected.

### Backend (Python ML Model)
1.  **Navigate to the backend directory:**
    ```bash
    cd lib/backend
    ```
2.  **Create and activate a virtual environment (recommended):**
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```
3.  **Install Python dependencies:**
    A `requirements.txt` file was not found in the backend directory. You may need to install common libraries used in such projects. Based on the project files, these might include:
    ```bash
    pip install pandas numpy scikit-learn flask
    ```
    It's recommended to create a `requirements.txt` file based on the actual imports in the Python scripts for easier dependency management.
4.  **Run the backend server (if applicable):**
    The backend seems to include an API component. You might need to run a main script to start the server (e.g., Flask development server):
    ```bash
    python main.py 
    ```
    (This is an assumption; check `main.py` or relevant API scripts for actual run commands).

## Future Enhancements
We are constantly looking for ways to improve AgriAdvisor. Here are some potential future enhancements:
-   **Real-time Weather Integration:** Incorporate live weather data from APIs to provide more dynamic and context-aware crop rotation recommendations.
-   **Expanded Crop Database:** Significantly increase the variety of crops in our database, including more regional and specialized options, to cater to a broader range of agricultural needs.
-   **User Accounts & Field Management:** Introduce user accounts allowing farmers to save their field data, track crop rotation history, and monitor soil health changes over time for personalized insights.

## License
This project is licensed under the MIT License.
