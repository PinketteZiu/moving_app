# Création des pièces par défaut
rooms = [
  { name: "Salon", description: "Pièce principale avec canapé, télé et bibliothèque" },
  { name: "Cuisine", description: "Électroménager, vaisselle et ustensiles" },
  { name: "Chambre", description: "Lit, armoire et affaires personnelles" },
  { name: "Buanderie", description: "Lave-linge, Sèche-linge" },
  { name: "Salle de bain", description: "Produits d'hygiène et serviettes" },
  { name: "Cave/Garage", description: "Objets de stockage et outils" }
]

rooms.each do |room_data|
  Room.find_or_create_by(name: room_data[:name]) do |room|
    room.description = room_data[:description]
  end
end

# Création d'exemples d'objets et de cartons
if Rails.env.development?
  salon = Room.find_by(name: "Salon")
  cuisine = Room.find_by(name: "Cuisine")

  if salon
    # Quelques objets pour le salon
    items = [
      { name: "Canapé 3 places", description: "Canapé en cuir marron", value: 800, condition: "good" },
      { name: "Table basse", description: "Table en bois massif", value: 150, condition: "excellent" },
      { name: "Télévision", description: "TV LED 55 pouces", value: 600, condition: "excellent" },
      { name: "Bibliothèque", description: "Étagère en pin avec livres", value: 200, condition: "fair" }
    ]

    items.each do |item_data|
      salon.items.find_or_create_by(name: item_data[:name]) do |item|
        item.description = item_data[:description]
        item.value = item_data[:value]
        item.condition = item_data[:condition]
      end
    end

    # Quelques cartons pour le salon
    box1 = salon.boxes.find_or_create_by(number: "1") do |box|
      box.description = "Livres et magazines"
      box.destination_room = "Bureau"
    end

    box2 = salon.boxes.find_or_create_by(number: "2") do |box|
      box.description = "Coussins et plaids"
      box.destination_room = "Salon"
    end
  end

  if cuisine
    # Quelques objets pour la cuisine
    items = [
      { name: "Réfrigérateur", description: "Frigo combiné 300L", value: 400, condition: "good" },
      { name: "Micro-ondes", description: "Micro-ondes 25L", value: 80, condition: "excellent" },
      { name: "Batterie de cuisine", description: "Casseroles et poêles", value: 120, condition: "fair" }
    ]

    items.each do |item_data|
      cuisine.items.find_or_create_by(name: item_data[:name]) do |item|
        item.description = item_data[:description]
        item.value = item_data[:value]
        item.condition = item_data[:condition]
      end
    end

    # Carton pour la cuisine
    box3 = cuisine.boxes.find_or_create_by(number: "3") do |box|
      box.description = "Vaisselle et verres"
      box.destination_room = "Cuisine"
    end

    # Associer la batterie de cuisine au carton
    batterie = cuisine.items.find_by(name: "Batterie de cuisine")
    batterie.update(box: box3) if batterie
  end
end

puts "Base de données initialisée avec succès !"
puts "Pièces créées : #{Room.count}"
puts "Objets créés : #{Item.count}"
puts "Cartons créés : #{Box.count}"
