const price = () => {

  const priceInput = document.getElementById("item-price")

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const add_tax_price = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    add_tax_price.innerText = parseInt(inputValue * 0.1);
    profit.innerText = inputValue - Number(add_tax_price.innerText);
  })
 
 };
 
 window.addEventListener("turbo:load", price);
 window.addEventListener("turbo:render", price);