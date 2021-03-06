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
      vendor.inventory.each do |item, amount|
        total[item] += amount
      end

      total
    end
  end

  def sell(item, amount)
    leftover = amount
    return false if amount > total_inventory[item]

    vendors_that_sell(item).each do |vendor|
      carry_over = leftover
      leftover -= vendor.inventory[item]
      vendor.inventory[item] -= carry_over

      vendor.inventory[item] = 0 if vendor.inventory[item] <= 0
    end

    true
  end
end
