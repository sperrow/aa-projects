import merge from 'lodash/merge';
import { RECEIVE_ALL_POKEMON, RECEIVE_SINGLE_POKEMON, RECEIVE_NEW_POKEMON } from '../actions/pokemon_actions';

const pokemonReducer = (state = {}, action) => {
  Object.freeze(state);
  switch(action.type) {
    case RECEIVE_ALL_POKEMON:
      let newState = merge({}, state, action.pokemon);
      return newState;
    case RECEIVE_SINGLE_POKEMON:
      newState = merge({}, state);
      newState[action.pokemon.pokemon.id] = action.pokemon.pokemon;
      return newState;
    case RECEIVE_NEW_POKEMON:
      newState = merge({}, state, action.pokemon);
      return newState;
    default:
      return state;
  }
};

export default pokemonReducer;
