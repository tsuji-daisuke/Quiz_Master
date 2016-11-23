var BodyQuiz = React.createClass({
    getInitialState() {
        return {question: {}, result: {}}
    },

    componentDidMount() {
        $.getJSON('/api/v1/quiz.json', (response) => {
            this.setState({question: response})
        });
    },

    submitAnswer() {
        var id = this.refs.id.value;
        var answer = this.refs.answer.value;
        $.ajax({
            url: '/api/v1/quiz',
            type: 'POST',
            data: {result: {question_id: id, content: answer}},
            success: (response) => {
                this.setState({result: response});
            }
        });
    },

    render() {
        return (
            <div>
                <p>{this.state.question.content}</p>
                <input ref='answer' placeholder='Enter the Answer'/>
                <input type="hidden" ref="id" value={this.state.question.id}/>
                <button onClick={this.submitAnswer}>Submit</button>
                <p>{this.state.result.judgement}</p>
                <button><a href="/quiz_mode">Change Quiz</a></button>
            </div>
        )
    }
});