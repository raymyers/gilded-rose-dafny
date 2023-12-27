class Item {
  constructor (name: string, sellIn: int, quality: int)
  ensures this.name == name
  ensures this.quality == quality
  ensures this.sellIn == sellIn {
    this.name := name;
    this.quality := quality;
    this.sellIn := sellIn;
  }
  var quality: int
  var name: string
  var sellIn: int
  predicate valid()
    reads this {
    (isSulfuras(name) ==> quality == 80) &&
    (!isSulfuras(name) ==> 0 <= quality <= 50)
  }
}

function isSulfuras(name: string): bool {
  name == "Sulfuras, Hand of Ragnaros"
}

predicate allValid(items: array<Item>) reads items, items[..] {
  forall i :: 0 <= i < items.Length ==> items[i].valid()
}

method updateItems(items: array<Item>)
requires allValid(items)
ensures allValid(items)
  modifies items[..]
{

  for i := 0 to items.Length
  invariant allValid(items)
  {
    var item := items[i];
    assert item.valid();
    updateItem(item);
  }
}

method updateItem(item: Item)
  requires item.valid()
  ensures item.valid()
  modifies item
{
  if (item.name != "Aged Brie"
      && item.name != "Backstage passes to a TAFKAL80ETC concert") {
    if (item.quality > 0) {
      if (item.name != "Sulfuras, Hand of Ragnaros") {
        item.quality := item.quality - 1;
      }
    }
  } else {
    if (item.quality < 50) {
      item.quality := item.quality + 1;

      if (item.name == "Backstage passes to a TAFKAL80ETC concert") {
        if (item.sellIn < 11) {
          if (item.quality < 50) {
            item.quality := item.quality + 1;
          }
        }

        if (item.sellIn < 6) {
          if (item.quality < 50) {
            item.quality := item.quality + 1;
          }
        }
      }
    }
  }

  if (item.name != "Sulfuras, Hand of Ragnaros") {
    item.sellIn := item.sellIn - 1;
  }

  if (item.sellIn < 0) {
    if (item.name != "Aged Brie") {
      if (item.name != "Backstage passes to a TAFKAL80ETC concert") {
        if (item.quality > 0) {
          if (item.name != "Sulfuras, Hand of Ragnaros") {
            item.quality := item.quality - 1;
          }
        }
      } else {
        item.quality := item.quality - item.quality;
      }
    } else {
      if (item.quality < 50) {
        item.quality := item.quality + 1;
      }
    }
  }
}

function natToString(n: nat): string {
  match n
  case 0 => "0" case 1 => "1" case 2 => "2" case 3 => "3" case 4 => "4"
  case 5 => "5" case 6 => "6" case 7 => "7" case 8 => "8" case 9 => "9"
  case _ => natToString(n / 10) + natToString(n % 10)
}

function intToString(n: int): string {
  if n >= 0 then natToString(n)
  else "-" + natToString(-n)
}

method Main() {
  var item1 := new Item("+5 Dexterity Vest", 10, 20);
  var item2 := new Item("Aged Brie", 2, 0);
  var item3 := new Item("Elixir of the Mongoose", 5, 7);
  var item4 := new Item("Sulfuras, Hand of Ragnaros", 0, 80);
  var item5 := new Item("Sulfuras, Hand of Ragnaros", -1, 80);
  var item6 := new Item("Backstage passes to a TAFKAL80ETC concert", 15, 20);
  var item7 := new Item("Backstage passes to a TAFKAL80ETC concert", 10, 49);
  var item8 := new Item("Backstage passes to a TAFKAL80ETC concert", 5, 49);
  // this conjured item does not work properly yet
  var item9 := new Item("Conjured Mana Cake", 3, 6);
  var items := new Item[][item1, item2, item3, item4, item5, item6, item7, item8, item9];
  var days := 30;
  print("OMGHAI!\n");
  assert allValid(items);
  for day := 0 to days + 1
    modifies items[..] 
    invariant allValid(items)
    {
    print("-------- day " + intToString(day) + " --------\n");
    print("name, sellIn, quality\n");
    
    for i := 0 to items.Length {
      var item := items[i];
      print(item.name +
            ", " + intToString(item.sellIn) + ", " +
            intToString(item.quality) + "\n");
    }
    print("\n");
    
    updateItems(items);
  }
}