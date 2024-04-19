import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sample_auth/home_page.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();

  @override
  void dispose()
  {
    _titleController.dispose();
    _descriptionController.dispose();
  }

  void _savePost() async{
    User? user=FirebaseAuth.instance.currentUser;

    if(user!=null)
      {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('posts').add({
          'title':_titleController.text,
          'description':_descriptionController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post saved successfully'),),
        );
        _titleController.clear();
        _descriptionController.clear();
      }
  }

  void _saveJobPost() async{
    User? user=FirebaseAuth.instance.currentUser;

    if(user!=null)
    {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('jobs').add({
        'title':_titleController.text,
        'description':_descriptionController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Job Post saved successfully'),),
      );
      _titleController.clear();
      _descriptionController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _savePost,
                child: const Text('Save Post')
            ),
            ElevatedButton(
                onPressed: _saveJobPost,
                child: const Text('Save Job')
            ),
          ],
        ),
      )
    );
  }
}
