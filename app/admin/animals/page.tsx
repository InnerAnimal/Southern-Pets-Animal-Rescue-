'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'

interface Animal {
  id: string
  name: string
  type: string
  breed: string | null
  age: number | null
  status: string
  _count?: {
    images: number
  }
}

export default function AnimalsAdminPage() {
  const [animals, setAnimals] = useState<Animal[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetchAnimals()
  }, [])

  const fetchAnimals = async () => {
    try {
      const response = await fetch('/api/animals')
      const data = await response.json()
      setAnimals(data.animals || [])
    } catch (error) {
      console.error('Failed to fetch animals:', error)
    } finally {
      setLoading(false)
    }
  }

  if (loading) {
    return (
      <div className="p-6 max-w-7xl mx-auto">
        <h1 className="text-3xl font-bold text-gray-900 mb-6">Photo Upload - Manage Animals</h1>
        <p>Loading animals...</p>
      </div>
    )
  }

  return (
    <div className="p-6 max-w-7xl mx-auto">
      <h1 className="text-3xl font-bold text-gray-900 mb-2">Photo Upload - Manage Animals</h1>
      <p className="text-gray-600 mb-6">
        Select an animal to upload and manage photos
      </p>

      {animals.length === 0 ? (
        <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-6">
          <p className="text-yellow-800">
            No animals found. Add animals to the database first.
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {animals.map((animal) => (
            <div
              key={animal.id}
              className="border border-gray-200 rounded-lg p-6 hover:shadow-lg transition-shadow bg-white"
            >
              <h3 className="text-xl font-semibold text-gray-900 mb-2">
                {animal.name}
              </h3>
              <div className="text-sm text-gray-600 space-y-1 mb-4">
                <p>
                  <span className="font-medium">Type:</span> {animal.type}
                </p>
                {animal.breed && (
                  <p>
                    <span className="font-medium">Breed:</span> {animal.breed}
                  </p>
                )}
                {animal.age && (
                  <p>
                    <span className="font-medium">Age:</span> {animal.age} years
                  </p>
                )}
                <p>
                  <span className="font-medium">Status:</span>{' '}
                  <span
                    className={
                      animal.status === 'available'
                        ? 'text-green-600'
                        : animal.status === 'adopted'
                        ? 'text-blue-600'
                        : 'text-gray-600'
                    }
                  >
                    {animal.status}
                  </span>
                </p>
                {animal._count && (
                  <p>
                    <span className="font-medium">Photos:</span> {animal._count.images}
                  </p>
                )}
              </div>
              <Link
                href={`/admin/animals/${animal.id}/photos`}
                className="block w-full text-center bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition-colors font-medium"
              >
                Manage Photos
              </Link>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
