import values from 'lodash/values';

const selectAllPokemon = state => {
  return values(state.entities.pokemon);
};

export default selectAllPokemon;
