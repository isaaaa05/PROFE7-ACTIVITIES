import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final _eventController = TextEditingController();
  final _ratingController = TextEditingController();
  final _commentController = TextEditingController();
  final List<Map<String, String>> _feedbackList = [];
  Map<String, String>?
      _latestFeedback; // To store the latest submission for display

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final newFeedback = {
          'event': _eventController.text,
          'rating': _ratingController.text,
          'comment': _commentController.text,
        };
        _feedbackList.add(newFeedback);
        _latestFeedback = newFeedback; // Update latest feedback
        _eventController.clear();
        _ratingController.clear();
        _commentController.clear();
      });
    }
  }

  void _clearAllFeedback() {
    setState(() {
      _feedbackList.clear();
      _latestFeedback = null;
    });
  }

  void _showLatestFeedback() {
    if (_latestFeedback != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Latest Feedback'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Event: ${_latestFeedback!['event']}'),
              Text('Rating: ${_latestFeedback!['rating']}'),
              Text('Comment: ${_latestFeedback!['comment']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No feedback submitted yet.')));
    }
  }

  @override
  void dispose() {
    _eventController.dispose();
    _ratingController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Feedback'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/dashboard'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Submit Your Feedback',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _eventController,
                        decoration: const InputDecoration(
                          labelText: 'Event Name *',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Event name is required' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _ratingController,
                        decoration: const InputDecoration(
                          labelText: 'Rating (1-5) *',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        keyboardType:
                            TextInputType.number, // Restrict to numeric input
                        inputFormatters: [], // No additional formatters needed with validator
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Rating is required';
                          final rating = int.tryParse(value);
                          if (rating == null)
                            return 'Please enter a valid number';
                          if (rating < 1 || rating > 5)
                            return 'Rating must be between 1 and 5';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          labelText: 'Comments',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _latestFeedback == null
                            ? null
                            : _showLatestFeedback, // Disable when no feedback
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            minimumSize: const Size(double.infinity, 50)),
                        child: const Text('View Latest',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            minimumSize: const Size(double.infinity, 50)),
                        child: const Text('Submit Feedback',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _clearAllFeedback,
                  child: const Text('Clear All Feedback',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            const Text(
              'Previous Feedback',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            Expanded(
              child: SingleChildScrollView(
                // Added to ensure scrollability
                child: ListView.builder(
                  shrinkWrap: true, // Allows it to fit within the parent
                  physics:
                      const NeverScrollableScrollPhysics(), // Let SingleChildScrollView handle scrolling
                  itemCount: _feedbackList.length,
                  itemBuilder: (context, index) {
                    final feedback = _feedbackList[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text('Event: ${feedback['event']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rating: ${feedback['rating']}'),
                            Text('Comment: ${feedback['comment']}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _feedbackList.removeAt(index);
                              if (index == _feedbackList.length)
                                _latestFeedback = _feedbackList.isNotEmpty
                                    ? _feedbackList.last
                                    : null;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
