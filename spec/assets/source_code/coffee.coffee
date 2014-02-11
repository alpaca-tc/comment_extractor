# [-1-] singleline
class GiftModel
  constructor: (gifts) -> # [-3-] singleline
    @gifts = ko.observableArray gifts

    @addGift = =>
      @gifts.push({ name: "" })

    @removeGift = (gift) =>
      @gifts.remove gift

      regexp = /// # [-12-] regexp comment
      reg(exp) # [-13-] regexp comment
      reg(exp) # [-14-] regexp comment
      ///
    @save = (form) =>
      alert "Could now transmit to server: #{ko.utils.stringifyJson @gifts}"
  ###[-18-] singleline
[-19-] multi line
###
viewModel = new GiftModel(
  [
    { name: "Tall Hat", price: "39.95" } # [-23-] singleline
        { name: "Long Cloak", price: "120.00"}
  ])
ko.applyBindings viewModel
$("form").validate submitHandler: viewModel.save
