import { connect } from 'react-redux';
import { selectAllPokemon } from '../../reducers/selectors';
import { requestAllPokemon } from '../../actions/pokemon_actions';
import ItemDetail from './item_detail';

const mapStateToProps = (state, ownProps) => ({
  item: state.entities.items.filter(item => {
    return item.id === parseInt(ownProps.match.params.itemId);
  })
});

const mapDispatchToProps = dispatch => ({
});

export default connect(mapStateToProps, mapDispatchToProps)(ItemDetail);
