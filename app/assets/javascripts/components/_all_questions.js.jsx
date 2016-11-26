var AllQuestions = React.createClass({
    handleDelete(id) {
        this.props.handleDelete(id);
    },

    onUpdate(question, index) {
        this.props.onUpdate(question, index);
    },

    render() {
        var Table = ReactBootstrap.Table;

        var questions = this.props.questions.map((question, index) => {
            return (
                <Question question={question}
                          key={question.id}
                          index={index}
                          handleDelete={this.handleDelete.bind(this, question.id)}
                          handleUpdate={this.onUpdate}/>
            )
        });

        return (
            <div>
                <Table striped bordered condensed hover>
                    <thead>
                    <tr>
                        <th>Question</th>
                        <th>Answer</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                        {questions}
                    </tbody>
                </Table>


            </div>
        )
    }
});