String? getEmojiofPokemonType(String type) {
  const Map<String, String> emojiType = {
    'normal': '♟️',
    'fighting': '👊🏼',
    'flying': '🪽',
    'poison': '🟣',
    'ground': '⛱️',
    'rock': '🪨',
    'bug': '🐞',
    'ghost': '👻',
    'steel': '🩶',
    'fire': '🔥',
    'water': '🐟',
    'grass': '🌿',
    'electric': '⚡',
    'psychic': '🪬',
    'ice': '🧊',
    'dragon': '🐉',
    'dark': '🎩',
    'fairy': '✨',
    'stellar': '⭐',
    'unknown': '❔'
  };

  return emojiType[type];
}
