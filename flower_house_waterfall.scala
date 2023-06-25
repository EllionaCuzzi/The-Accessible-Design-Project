// MyFile.scala

// Imports
import scala.collection.mutable.Stack
import scala.collection.mutable.Map
import scala.collection.mutable.Set
import scala.util.control.Breaks._

// Global Variables
var accessFeatures: Map[String, Boolean] = Map()
val accessRequirements: Set[String] = Set("wheelchair accessible", 
										"accessible bathrooms", 
										"aids for vision impaired",
										"audio-guidance for deaf persons",
										"good lighting",
										"guard rails",
										"lowered counters",
										"ramps")

// Helper Functions
// Populate AccessFeatures
def populateAccessFeatures(featureMap: Map[String, Boolean]) {
	for(req <- accessRequirements) {
		featureMap(req) = false
	}
}

// Check Feature Requirements
def checkAccessibility(featureMap: Map[String, Boolean]): Boolean {
	var meetsReqs: Boolean = true
	breakable { 
		for(req <- accessRequirements) {
			if(featureMap(req) == false) {
				meetsReqs = false
				break
			}
		}
	}
	return meetsReqs
}

// Add Feature
def addAccessFeature(featureMap: Map[String, Boolean], feature: String) {
	featureMap(feature) = true
	
	// Check for Feature Completion
	if(checkAccessibility(featureMap)) {
		println("Accessibility Requirements Met!")
	}
}

// Main
def main() {
	// Populate Access Features
	populateAccessFeatures(accessFeatures)
	
	// Add features to make accessible
	addAccessFeature(accessFeatures, "wheelchair accessible")
	addAccessFeature(accessFeatures, "accessible bathrooms")
	addAccessFeature(accessFeatures, "aids for vision impaired")
	addAccessFeature(accessFeatures, "audio-guidance for deaf persons")
	addAccessFeature(accessFeatures, "good lighting")
	addAccessFeature(accessFeatures, "guard rails")
	addAccessFeature(accessFeatures, "lowered counters")
	addAccessFeature(accessFeatures, "ramps")
	
	// Done
	println("Done promoting universal design principles!")
}

// Call Main
main()