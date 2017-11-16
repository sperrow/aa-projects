import merge from 'lodash/merge';
import { RECEIVE_ALL_POKEMON } from '../actions/pokemon_actions';

const pokemonReducer = (state = {}, action) => {
  Object.freeze(state);
  switch(action.type) {
    case RECEIVE_ALL_POKEMON:
      const newState = merge({}, state, action.pokemon);
      return newState;
    default:
      return state;
  }
};

export default pokemonReducer;
