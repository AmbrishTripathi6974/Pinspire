// Interest category model for onboarding
// Represents selectable interest categories

/// Interest category for onboarding selection
class InterestCategory {
  const InterestCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String imageUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InterestCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Predefined interest categories matching Pinterest style
/// All categories displayed in a single scrollable grid
class InterestCategories {
  InterestCategories._();

  static const List<InterestCategory> all = [
    // Row 1
    InterestCategory(
      id: 'cars',
      name: 'Cars',
      imageUrl: 'https://images.pexels.com/photos/3802510/pexels-photo-3802510.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'pop_culture',
      name: 'Pop culture',
      imageUrl: 'https://images.pexels.com/photos/1190297/pexels-photo-1190297.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'party_ideas',
      name: 'Party ideas',
      imageUrl: 'https://images.pexels.com/photos/1071882/pexels-photo-1071882.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    // Row 2
    InterestCategory(
      id: 'workouts',
      name: 'Workouts',
      imageUrl: 'https://images.pexels.com/photos/841130/pexels-photo-841130.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'cute_animals',
      name: 'Cute animals',
      imageUrl: 'https://images.pexels.com/photos/1805164/pexels-photo-1805164.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'home_renovation',
      name: 'Home renovation',
      imageUrl: 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    // Row 3
    InterestCategory(
      id: 'small_spaces',
      name: 'Small spaces',
      imageUrl: 'https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'travel',
      name: 'Travel',
      imageUrl: 'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'diy_projects',
      name: 'DIY projects',
      imageUrl: 'https://images.pexels.com/photos/1573828/pexels-photo-1573828.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    // Row 4
    InterestCategory(
      id: 'nail_trends',
      name: 'Nail trends',
      imageUrl: 'https://images.pexels.com/photos/704815/pexels-photo-704815.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'phone_wallpapers',
      name: 'Phone wallpapers',
      imageUrl: 'https://images.pexels.com/photos/1287145/pexels-photo-1287145.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'tattoos',
      name: 'Tattoos',
      imageUrl: 'https://images.pexels.com/photos/955938/pexels-photo-955938.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    // Row 5
    InterestCategory(
      id: 'comics',
      name: 'Comics',
      imageUrl: 'https://images.pexels.com/photos/3832028/pexels-photo-3832028.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'customisation',
      name: 'Customisa-tion',
      imageUrl: 'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'aesthetics',
      name: 'Aesthetics',
      imageUrl: 'https://images.pexels.com/photos/2387793/pexels-photo-2387793.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    // Row 6
    InterestCategory(
      id: 'cooking',
      name: 'Cooking',
      imageUrl: 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'photography',
      name: 'Photography',
      imageUrl: 'https://images.pexels.com/photos/212372/pexels-photo-212372.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'home_decor',
      name: 'Home décor',
      imageUrl: 'https://images.pexels.com/photos/1643383/pexels-photo-1643383.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    // Row 7
    InterestCategory(
      id: 'baking',
      name: 'Baking',
      imageUrl: 'https://images.pexels.com/photos/205961/pexels-photo-205961.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'cute_greetings',
      name: 'Cute greetings',
      imageUrl: 'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'quotes',
      name: 'Quotes',
      imageUrl: 'https://images.pexels.com/photos/267355/pexels-photo-267355.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    // Row 8
    InterestCategory(
      id: 'drawing',
      name: 'Drawing',
      imageUrl: 'https://images.pexels.com/photos/1762851/pexels-photo-1762851.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'classroom_ideas',
      name: 'Classroom ideas',
      imageUrl: 'https://images.pexels.com/photos/1370296/pexels-photo-1370296.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    InterestCategory(
      id: 'fashion',
      name: 'Fashion',
      imageUrl: 'https://images.pexels.com/photos/994234/pexels-photo-994234.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    // Row 9
    InterestCategory(
      id: 'cozy_vibes',
      name: 'Cozy vibes',
      imageUrl: 'https://images.pexels.com/photos/1906439/pexels-photo-1906439.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
  ];
}
