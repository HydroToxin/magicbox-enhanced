function initAdminBatchForm() {
  // Check if the form with the specific ID is present in the DOM
  const adminBatchForm = document.getElementById("admin-batch-form") as HTMLFormElement | null;

  if (!adminBatchForm) {
    return; // Exit the function if the form is not present
  }

  const batchPriceInput = document.getElementById("batch_batch_price") as HTMLInputElement | null;
  const batchWeightInput = document.getElementById("batch_batch_weight") as HTMLInputElement | null;
  const pricePerWeightInput = document.getElementById("batch_price_per_weight") as HTMLInputElement | null;
  const totalWeightInput = document.getElementById("batch_total_weight") as HTMLInputElement | null;
  const batchCountInput = document.getElementById("batch_batch_count") as HTMLInputElement | null;

  // Attach event listeners only if relevant inputs exist
  if (batchPriceInput && batchWeightInput && pricePerWeightInput) {
    batchPriceInput.addEventListener("change", handleBatchPriceChange);
    pricePerWeightInput.addEventListener("change", handlePricePerWeightChange);
  }

  if (totalWeightInput && batchWeightInput && batchCountInput) {
    totalWeightInput.addEventListener("change", updateBatchCount);
    batchWeightInput.addEventListener("change", updateBatchCount);
  }
}

function handleBatchPriceChange() {
  const batchPriceInput = document.getElementById("batch_batch_price") as HTMLInputElement | null;
  const batchWeightInput = document.getElementById("batch_batch_weight") as HTMLInputElement | null;
  const pricePerWeightInput = document.getElementById("batch_price_per_weight") as HTMLInputElement | null;

  const batchPrice = batchPriceInput ? parseFloat(batchPriceInput.value) : NaN;
  const batchWeight = batchWeightInput ? parseFloat(batchWeightInput.value) : NaN;

  if (!isNaN(batchPrice) && !isNaN(batchWeight) && batchWeight !== 0 && pricePerWeightInput) {
    pricePerWeightInput.value = (batchPrice / batchWeight).toFixed(2);
  }
}

function handlePricePerWeightChange() {
  const batchWeightInput = document.getElementById("batch_batch_weight") as HTMLInputElement | null;
  const pricePerWeightInput = document.getElementById("batch_price_per_weight") as HTMLInputElement | null;
  const batchPriceInput = document.getElementById("batch_batch_price") as HTMLInputElement | null;

  const batchWeight = batchWeightInput ? parseFloat(batchWeightInput.value) : NaN;
  const weightPrice = pricePerWeightInput ? parseFloat(pricePerWeightInput.value) : NaN;

  if (!isNaN(batchWeight) && !isNaN(weightPrice) && batchPriceInput) {
    batchPriceInput.value = (batchWeight * weightPrice).toFixed(2);
  }
}

function updateBatchCount() {
  const totalWeightInput = document.getElementById("batch_total_weight") as HTMLInputElement | null;
  const batchWeightInput = document.getElementById("batch_batch_weight") as HTMLInputElement | null;
  const batchCountInput = document.getElementById("batch_batch_count") as HTMLInputElement | null;

  const total = totalWeightInput ? parseFloat(totalWeightInput.value) : NaN;
  const weight = batchWeightInput ? parseFloat(batchWeightInput.value) : NaN;

  if (!isNaN(total) && !isNaN(weight) && weight !== 0 && batchCountInput) {
    batchCountInput.value = (total / weight).toFixed(2);
  }
}

// Initialize the function with different events
document.addEventListener("DOMContentLoaded", initAdminBatchForm);
document.addEventListener("turbo:load", initAdminBatchForm);
document.addEventListener("nested:fieldAdded", initAdminBatchForm);
