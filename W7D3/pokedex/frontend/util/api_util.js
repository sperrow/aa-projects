export const fetchAllPokemon = () => {
  return $.ajax({
    method: 'GET',
    url: 'api/pokemon'
  });
};

export const fetchSinglePokemon = (id) => {
  return $.ajax({
    method: 'GET',
    url: `api/pokemon/${id}`
  });
};

export const createNewPokemon = (params) => {
  return $.ajax({
    method: 'POST',
    url: 'api/pokemon'
  });
};
