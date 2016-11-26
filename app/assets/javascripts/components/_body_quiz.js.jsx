var BodyQuiz = React.createClass({
    getInitialState() {
        return {question: {}, result: {}, id: '', answer: ''}
    },

    componentDidMount() {
        $.getJSON('/api/v1/quiz.json', (response) => {
            this.setState({question: response})
        });
    },

    submitAnswer() {
        var id = this.state.question.id;
        var answer = this.state.answer;
        console.log(id);
        console.log(answer);
        $.ajax({
            url: '/api/v1/quiz',
            type: 'POST',
            data: {result: {question_id: id, content: answer}},
            success: (response) => {
                this.setState({result: response});
            }
        });
    },

    handleAnswerChange(e) {
        this.setState({answer: e.target.value})
    },

    render() {
        var FormGroup = ReactBootstrap.FormGroup;
        var FormControl = ReactBootstrap.FormControl;
        var Form = ReactBootstrap.Form;
        var Col = ReactBootstrap.Col;
        var ControlLabel = ReactBootstrap.ControlLabel;
        var Button = ReactBootstrap.Button;
        var Label = ReactBootstrap.Label;
        var Alert = ReactBootstrap.Alert;

        var judgement;
        if (this.state.result.judgement) {
            if (this.state.result.judgement == 'No!... Please retry.') {
                judgement = <Alert bsStyle="warning">{this.state.result.judgement}</Alert>;
            } else {
                judgement = <Alert>{this.state.result.judgement}</Alert>;
            }
        }

        return (
            <div>
                <h3><Label bsStyle="info">{this.state.question.content}</Label></h3>
                <Form horizontal>
                    <FormGroup controlId="formQuiz">
                        <Col sm={8}>
                            <FormControl ref="answer" value={this.state.answer} onChange={this.handleAnswerChange}
                                         type="text" placeholder="Enter the Answer"/>
                        </Col>
                    </FormGroup>
                </Form>

                <Button bsStyle="primary"  onClick={this.submitAnswer}>Submit</Button>
                    {judgement}
                <div style={{marginTop: 100}}>
                    <Button bsStyle="link" href="/quiz_mode">Change Quiz</Button>
                </div>
            </div>
        )
    }
});