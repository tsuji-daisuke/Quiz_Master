var Question = React.createClass({
    getInitialState() {
        return {editable: false, content: this.props.question.content, answer: this.props.question.answer}
    },
    handleEdit() {
        if (this.state.editable) {
            var id = this.props.question.id;
            var content = this.state.content;
            var answer = this.state.answer;
            var question = {id: id, content: content, answer: answer};
            this.props.handleUpdate(question, this.props.index);

        }
        this.setState({editable: !this.state.editable})
    },
    handleContentChange(e) {
        this.setState({content: e.target.value})
    },
    handleAnswerChange(e) {
        this.setState({answer: e.target.value})
    },

    render() {
        var Button = ReactBootstrap.Button;
        var FormControl = ReactBootstrap.FormControl;

        var content = this.state.editable ?
            <FormControl type='text' ref='content' value={this.state.content} onChange={this.handleContentChange}/> :
            <p>{this.props.question.content}</p>;
        var answer = this.state.editable ?
            <FormControl type='text' ref='answer' value={this.state.answer} onChange={this.handleAnswerChange}/> :
            <p>{this.props.question.answer}</p>;

        return (
            <tr>
                <td>{content}</td>
                <td>{answer}</td>
                <td>
                    <Button bsStyle="info"
                            onClick={this.handleEdit}> {this.state.editable ? 'Submit' : 'Edit' } </Button>
                    <Button bsStyle="danger" onClick={this.props.handleDelete}>Delete</Button>
                </td>
            </tr>
        )
    }
});