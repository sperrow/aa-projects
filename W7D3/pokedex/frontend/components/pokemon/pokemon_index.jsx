import React from 'react';

export default class PokemonIndex extends React.Component {

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    const pokemonList = this.props.pokemon.map((poke) => (
      <li key={poke.id}><img src={poke.image_url} height="45" />{poke.name}</li>
    ));

    return (
      <ul>{pokemonList}</ul>
    );
  }
}
