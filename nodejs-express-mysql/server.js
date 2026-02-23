const express = require("express");
const cors = require("cors");

const app = express();

/*
  CORS Configuration
  Allow requests from anywhere (for testing / ALB / S3 / Nginx)
*/
app.use(cors({
  origin: "*",
  methods: ["GET", "POST", "PUT", "DELETE"],
  credentials: false
}));

// Parse requests of content-type - application/json
app.use(express.json());

// Parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: true }));

// Simple test route
app.get("/", (req, res) => {
  res.json({ message: "Welcome to bezkoder application." });
});

// Routes
require("./app/routes/tutorial.routes.js")(app);

// Set port and listen for requests
const PORT = process.env.PORT || 3000;

app.listen(PORT, "0.0.0.0", () => {
  console.log(`New Deployment Test`);
});
