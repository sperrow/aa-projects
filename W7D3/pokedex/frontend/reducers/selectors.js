import values from 'lodash/values';

export const selectAllPokemon = state => {
  return values(state.entities.pokemon);
};

export const selectSinglePokemon = state => {
  const id = state.ui.pokeDisplay;
  return state.entities.pokemon[id];
};

export const selectItems = state => {
  return state.entities.items;
};

export const selectPokemonItem = (state, itemId) => {
  return state.entities.items[itemId];
};
