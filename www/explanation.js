function explanationPatients() {
    document.getElementById("explanationText").innerHTML = "Total number of patients in study " +
                                                           "(evenly distributed over doseages).";
}
function explanationBaseline() {
    document.getElementById("explanationText").innerHTML = "Baseline.";
}
function explanationED50() {
    document.getElementById("explanationText").innerHTML = "Median effective dose.";
}
function explanationEmax() {
    document.getElementById("explanationText").innerHTML = "Maximum response.";
}
function explanationDose() {
    document.getElementById("explanationText").innerHTML = "Applied doseage in arbitrary units.";
}
function offExplanation() {
    document.getElementById("explanationText").innerHTML = "Description of variables.";
}
