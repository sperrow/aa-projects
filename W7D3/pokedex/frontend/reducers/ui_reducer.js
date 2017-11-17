import merge from 'lodash/merge';
import { RECEIVE_SINGLE_POKEMON } from '../actions/pokemon_actions';

const uiReducer = (state = {}, action) => {
  Object.freeze(state);
  switch(action.type) {
    case RECEIVE_SINGLE_POKEMON:
      const newState = merge({}, state, {pokeDisplay: action.pokemon.pokemon.id});
      return newState;
    default:
      return state;
  }
};

export default uiReducer;
