import * as APIUtil from '../util/api_util';
export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_SINGLE_POKEMON = "RECEIVE_SINGLE_POKEMON";
export const RECEIVE_NEW_POKEMON = "RECEIVE_NEW_POKEMON";

export const receiveAllPokemon = pokemon => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const requestAllPokemon = () => {
  return (dispatch) => {
    APIUtil.fetchAllPokemon()
    .then((pokemon) => dispatch(receiveAllPokemon(pokemon)));
   };
};

export const receiveSinglePokemon = pokemon => ({
  type: RECEIVE_SINGLE_POKEMON,
  pokemon
});

export const requestSinglePokemon = (id) => {
  return (dispatch) => {
    APIUtil.fetchSinglePokemon(id)
    .then((pokemon) => dispatch(receiveSinglePokemon(pokemon)));
   };
};

export const receiveNewPokemon = pokemon => ({
  type: RECEIVE_NEW_POKEMON,
  pokemon
});


export const createNewPokemon = () => {
  return (dispatch) => {
    APIUtil.createNewPokemon()
    .then((pokemon) => dispatch(receiveNewPokemon(pokemon)));
   };
};
