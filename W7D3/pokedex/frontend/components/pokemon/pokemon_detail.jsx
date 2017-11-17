import React from 'react';
import { Link, Route } from 'react-router-dom';
import ItemDetailContainer from '../items/item_detail_container';

export default class PokemonDetail extends React.Component {

  componentDidMount() {
    const id = this.props.match.params.id;
    this.props.requestSinglePokemon(id);
  }

  componentWillReceiveProps(newProps) {
    if(this.props.match.params.id !== newProps.match.params.id) {
      this.props.requestSinglePokemon(newProps.match.params.id);
    }
  }

  render() {
    let pokemon = this.props.pokemon;
    let content = '';
    if (pokemon) {
      let items = this.props.items.map(item => (
        <li key={item.id}>
          <Link to={`/pokemon/${pokemon.id}/item/${item.id}`}>
            <img className="item-img" src={item.image_url} />
          </Link>
        </li>
      ));
      content = (
        <section className="pokemon-detail">
          <img className="detail-img" src={pokemon.image_url} />
          <ul>
            <li><h2>{pokemon.name}</h2></li>
            <li>Type: {pokemon.type}</li>
            <li>Attack: {pokemon.attack}</li>
            <li>Defense: {pokemon.defense}</li>
            <li>Moves: {pokemon.moves.join(', ')}</li>
          </ul>
          <section className="items-section">
            <h3>Items</h3>
            <ul className="items-list">
              {items}
            </ul>
          </section>
          <Route path="/pokemon/:id/item/:itemId" component={ItemDetailContainer} />
        </section>
      );
    }
    return content;
  }
}
