// Visitor counter updater

// API endpoint to fetch visitor count
const apiEndpoint = "https://mf48ygd5sh.execute-api.us-east-1.amazonaws.com/prod/increment" // Replace with API Gateway endpoint URL

// Function to call Lambda function through API Gateway
async function updateVisitorCount() {
  try {
    
    // Check if visitor has already been counted this session
    if (sessionStorage.getItem("visitorCounted")) {
      console.log("Visitor already counted in this session.")
      return; // Exit early
    }

    // Send POST request to Lambda function via API Gateway endpoint
    const response = await fetch(apiEndpoint, { method: "POST"})

    // Check if response is ok (status code 200)
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    // Convert response to JSON
    const data = await response.json();

    // Extract visitor count from response (returned as count)
    const count = data.count;

    // Update visitor count in HTML
    document.getElementById("visitor-count").innerText = count;

    // Mark session as already counted
    sessionStorage.setItem("visitorCounted", "true")

    } catch (error) {
        // In case of error, show message and log
        console.error("Error fetching visitor count.", error);
        document.getElementById("visitor-count").innerText="Error fetching count";   
  }
}

// Call the function to fetch visitor count when the page loads
updateVisitorCount()

// trigger workflow