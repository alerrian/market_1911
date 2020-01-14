class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors.push(vendor)
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.map do |vendor|
      vendor if vendor.inventory.find { |items| items[0].name == item.name }
    end.compact
  end

  def sorted_item_list
    @vendors.map do |vendor|
      vendor.inventory.keys.map do |item|
        item.name
      end
    end.flatten.uniq.sort
  end

  def total_inventory
    @vendors.inject(Hash.new(0)) do |total, vendor|
      require 'pry'; binding.pry
    end
  end
end
