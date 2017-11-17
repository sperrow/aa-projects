import React from 'react';
import { Link } from 'react-router-dom';

export default class PokemonIndexItem extends React.Component {
  render() {
    const pokemon = this.props.pokemon;
    let url = `/pokemon/${pokemon.id}`;
    return (
      <li>
        <Link to={url}>
          <img className="thumbnail-img" src={pokemon.image_url} />{pokemon.name}
        </Link>
      </li>
    );
  }
}
