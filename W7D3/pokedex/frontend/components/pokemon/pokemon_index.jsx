import React from 'react';
import { Route } from 'react-router-dom';
import PokemonIndexItem from './pokemon_index_item';
import PokemonDetailContainer from './pokemon_detail_container';

export default class PokemonIndex extends React.Component {

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    const pokemonList = this.props.pokemon.map((poke) => (
      <PokemonIndexItem key={poke.id} pokemon={poke} />
    ));

    return (
      <div className="main">
        <ul>{pokemonList}</ul>
        <Route path="/pokemon/:id" component={PokemonDetailContainer} />
      </div>
    );
  }
}
