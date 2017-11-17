import React from 'react';
import { Link } from 'react-router-dom';

export default class ItemDetail extends React.Component {
  render() {
    const item = this.props.item[0];
    return (
      <ul>
        <li>{item.name}</li>
        <li>Happiness: {item.happiness}</li>
        <li>Price: ${item.price}</li>
      </ul>
    );
  }
}
